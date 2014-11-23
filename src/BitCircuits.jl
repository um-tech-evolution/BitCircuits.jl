module BitCircuits

export Operation, Constant, Variable, evaluate, equal

typealias BitString Uint64
typealias VarIdx Uint64
typealias Context Uint64

abstract Node

# ----------------
# Variable context
# ----------------

immutable Context2
    bits::Uint64
    function Context(bits::Uint64)
        if bits > 63
            error("ctx must be between 000000 (0) and 111111 (63)")
        end
        return new(bits)
    end
end

Context2(bits::Int64) = Context2(uint64(bits))

# ----------
# Operations
# ----------

immutable Operation <: Node
    sym::String
    left::Node
    right::Node
    cache::BitString
end

function Operation(func::Function, left::Node, right::Node)
    sym = string(func)
    cache = func(left.cache, right.cache)
    return Operation(sym, left, right, cache)
end

# ---------
# Constants
# ---------

immutable Constant <: Node
    val::Bool
    sym::String
    cache::BitString
    function Constant(val::Bool)
        if val
            cache = 2 ^ 64 - 1
            sym = "TRUE"
        else
            cache = 0
            sym = "FALSE"
        end
        return new(val, sym, cache |> uint64)
    end
end

# ---------
# Variables
# ---------

immutable Variable <: Node
    idx::VarIdx
    sym::String
    cache::BitString
    function Variable(idx::Uint64)
        if idx > 5
            error("idx must be  in [0, 5]")
        end
        cache = 0
        for ctxval = uint64(0):uint64(63)
            varmask = 2 ^ idx |> uint64
            if (ctxval & varmask) > 0
                cache = cache | (2 ^ ctxval)
            end
        end
        return new(idx, "X$(idx)", cache)
    end
end

Variable(idx::Int64) = Variable(uint64(idx))

# ---------------
# Tree evaluation
# ---------------

function evaluate(root::Node, ctxval::Context)
    mask = 2 ^ ctxval |> uint64
    return root.cache & mask > 0
end

evaluate(root::Node, ctxval::Uint8) = evaluate(root, ctxval |> uint64)

# ---------------
# Tree comparison
# ---------------

function equal(left::Node, right::Node)
    return left.cache == right.cache
end

end
