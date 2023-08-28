module JSONSchemaGenerator

export make_schema, roundtrip

using OrderedCollections, JSON3, StructTypes


D = OrderedDict{Symbol, Any}
d(; kw...) = D(kw...)

roundtrip(x) = JSON3.read(JSON3.write(x))

gen(x) = gen(StructTypes.StructType(x), x)

gen(::StructTypes.StringType, x) = d(type = "string")
gen(::StructTypes.NumberType, x) = d(type = "number")
gen(::StructTypes.BoolType, x) = d(type = "boolean")
gen(::StructTypes.NullType, x) = d(type = "null")

gen(::StructTypes.ArrayType, x::AbstractVector{T}) where {T} = d(type = "array", items = gen(T, x[1]))
gen(::StructTypes.ArrayType, x::Tuple) = d(type = "array", prefixItems = gen.(x))

gen(::StructTypes.DictType, x) = d(type = "object", properties = D(Symbol(k) => gen(v) for (k,v) in pairs(x)))

gen(::StructTypes.SingletonType, x) = error("SingletonType not supported")

# Everything else: roundtrip it to see what JSON3 does with it.
gen(::Any, x) = gen(roundtrip(x))



end
