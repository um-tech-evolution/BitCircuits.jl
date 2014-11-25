# BitCircuits

[![Build Status](https://travis-ci.org/um-tech-evolution/BitCircuits.jl.svg?branch=master)](https://travis-ci.org/um-tech-evolution/BitCircuits.jl)

Boolean circuit tree implementation that uses bit strings to cache evaluation
results and bitwise operations to evaluate new circuits based on existing trees.

## API

The API is very simple. Trees consist of `Operation`s (interior nodes),
`Variable`s, and `Constant`s (both of which are leaf nodes). Right now all
operations are functions of two parameters.

### Variable

The constructor takes a single parameter, an integer in `[0,5]` (there are six
possible variables.

### Constant

The constructor takes a single boolean.

### Operation

The constructor takes a function to apply, this must be a bitwise function that
can operate on integers, and two sub-trees, to which the function will be
applied.

### evaluate

Evaluates a tree for a given set of variable values. The variable values are
specified as a bit string, where variable 5 is the high order bit and variable 0
is the low order bit.

### equal

Determine whether two trees describe the same function.

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

equal(p, q) # false
```
