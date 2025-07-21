include("braket.jl")
using .Braket

# Define some sample kets
a = Ket([1.0 + 0im, 0.0 + 0im])
b = Ket([0.0 + 0im, 1.0 + 0im])

println("inner(a,a) = ", inner(a,a))
println("inner(a,b) = ", inner(a,b))

out = outer(a,b)
println("outer(a,b) = ")
println(out)

tens = tensor(a,b)
println("tensor(a,b) = ", tens.data)

println("translation operator L=2:")
println(translation_operator(2))

println("site inversion operator L=2:")
println(site_inversion_operator(2))

println("spin inversion operator L=2:")
println(spin_inversion_operator(2))
