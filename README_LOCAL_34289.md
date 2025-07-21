# Braket Example

This repository contains a simple implementation of bra-ket calculations in Julia without relying on external packages. The `braket.jl` module defines utilities for creating kets, computing inner/outer products, forming tensor products and constructing simple symmetry operators.

## Files
- `braket.jl` – module with core functions and symmetry operators
- `test_braket.jl` – example usage script

## Usage
Run the example script with Julia:

```bash
julia test_braket.jl
```

The script prints inner products, outer products, tensor products, and examples of the translation, site inversion, and spin inversion operators.

The module also exposes basic Pauli spin matrices `σx`, `σy`, `σz` and helper functions `translation_operator`, `site_inversion_operator`, and `spin_inversion_operator` for small spin chains.
