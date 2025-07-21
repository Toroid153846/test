module Braket

export Ket, bra, inner, outer, tensor

"""A ket represented by a vector of complex numbers"""
struct Ket
    data::Vector{ComplexF64}
end

"""Return the bra (conjugate transpose) of a ket"""
function bra(k::Ket)
    conj.(k.data)
end

"""Compute inner product between two kets"""
function inner(k1::Ket, k2::Ket)
    sum(conj.(k1.data) .* k2.data)
end

"""Compute inner product between a bra vector and a ket"""
function inner(bra::Vector{ComplexF64}, k::Ket)
    sum(bra .* k.data)
end

"""Compute outer product of two kets"""
function outer(k1::Ket, k2::Ket)
    k1.data * (conj.(k2.data))'
end

"""Tensor product (Kronecker) of two kets"""
function tensor(k1::Ket, k2::Ket)
    n1 = length(k1.data)
    n2 = length(k2.data)
    result = Vector{ComplexF64}(undef, n1 * n2)
    for i in 1:n1
        for j in 1:n2
            result[(i - 1) * n2 + j] = k1.data[i] * k2.data[j]
        end
    end
    Ket(result)
end

end # module
