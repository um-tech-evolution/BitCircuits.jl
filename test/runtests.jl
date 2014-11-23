using BitCircuits
using Base.Test

or(left, right) = left | right
and(left, right) = left & right

# Demo using the following equivalency:
# p <- ab + ac
# q <- a (b + c)
# p = q

a = Variable(0)
b = Variable(1)
c = Variable(2)

ab = Operation(and, a, b)
ac = Operation(and, a, c)
p = Operation(or, ab, ac)
boc = Operation(or, b, c)
q = Operation(and, a, boc)

@test equal(p, q)
@test evaluate(ab, 0b000011) == true
@test evaluate(ab, 0b000010) == false
@test evaluate(ab, 0b000001) == false
@test evaluate(ab, 0b000000) == false
