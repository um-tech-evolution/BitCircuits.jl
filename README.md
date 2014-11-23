# BitCircuits

[![Build Status](https://travis-ci.org/um-tech-evolution/BitCircuits.jl.svg?branch=master)](https://travis-ci.org/um-tech-evolution/BitCircuits.jl)

Boolean circuit tree implementation that uses bit strings to cache evaluation
results and bitwise operations to evaluate new circuits based on existing trees.

## Examples

```julia
using BitCircuits

and(left, right) = left & right
or(left, right) = left | right

a = Variable(0)
b = Variable(1)

p = Operation(or, a, b) # p = a + b
q = Operation(and, a, b) # q = ab
r = Operation(and, a, p) # r = a(a + b)

evaluate(p, 0b000010) # true
evaluate(p, 0b000000) # false
```
