# JSONSchemaGenerator

[![Build Status](https://github.com/joshday/JSONSchemaGenerator.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/joshday/JSONSchemaGenerator.jl/actions/workflows/CI.yml?query=branch%3Amain)




# The Goal:

Create a function that inputs a `Type` and generates a JSON Schema such that:

1. `JSON3.write(::MyType)` creates JSON that is valid against the schema.
2. `JSON3.read(x, MyType)` will work when `x` is valid against the schema.


We don't need to deal with:
