module Braket

using LinearAlgebra

export Ket, bra, inner, outer, tensor,
       σx, σy, σz,
       translation_operator, site_inversion_operator,
       spin_inversion_operator

"""Pauli spin matrices"""
const σx = ComplexF64[0 1; 1 0]
const σy = ComplexF64[0 -im; im 0]
const σz = ComplexF64[1 0; 0 -1]

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

"""Translate a spin chain of length L by one site to the right"""
function translation_operator(L::Int)
    dim = 2^L
    op = zeros(ComplexF64, dim, dim)
    mask = dim - 1
    for i in 0:dim-1
        j = ((i & 1) << (L - 1)) | (i >> 1)
        op[j + 1, i + 1] = 1
    end
    op
end

"""Reverse the order of sites in a spin chain of length L"""
function site_inversion_operator(L::Int)
    dim = 2^L
    op = zeros(ComplexF64, dim, dim)
    for i in 0:dim-1
        j = 0
        for p in 1:L
            bit = (i >> (p - 1)) & 1
            j |= bit << (L - p)
        end
        op[j + 1, i + 1] = 1
    end
    op
end

"""Flip all spins in a chain of length L"""
function spin_inversion_operator(L::Int)
    dim = 2^L
    op = zeros(ComplexF64, dim, dim)
    mask = dim - 1
    for i in 0:dim-1
        j = (~i) & mask
        op[j + 1, i + 1] = 1
    end
    op
end
end # module
