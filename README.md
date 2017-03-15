# CSoM


[![Build Status](https://travis-ci.org/goedman/CSoM.jl.svg?branch=master)](https://travis-ci.org/goedman/CSoM.jl)


##Access to CSoM models

This Julia package contains the programs in chapters 4 to 6 as described in "Programming the Finite Element Method" by I M Smith, D V Griffiths and L. Margetts ([PtFEM]( http://www.wiley.com/WileyCDA/WileyTitle/productCd-1119973341.html )). 

The package should probably be called PtFEM.jl, but for now I have always related them to Colorado School of Mines (being a mining engineer from Delft University myself :-), hence [CSoM.jl](https://github.com/goedman/CSoM.jl). When I refer to the book I use PtFEM, when I refer to the Julia package I use CSoM.

To use the toolkit and run several test programs, start the [Julia](http://julialang.org) REPL and type:

```
Pkg.clone("git@github.com:goedman/CSoM.jl")
Pkg.test("CSoM")
```

As this shows, the package has not yet been published and is currently only available through cloning from my github account. I will approach the authors if they will allow me to publish the CSoM toolkit.

Example programs are in the examples/... and notebooks/... subdirectories. Currently the notebooks are just initial examples (and might not always work) until the structure of the toolkit gels.

Initial focus has been on chapters 4 to 6 of PtFEM in order to figure out how to best structure the toolkit. 

For now I have opted for introducing an extra layer in CSoM compared with PtFEM by introducing higher level 'computational flow templates' which can be found in the src/"chapter title" directories, e.g. the src/"4 Static Equilibrium" subdirectory for PtFEM programs in chapter 4. In PtFEM no such intermediate template level is used.

The idea of the templates is that they can be used to quickly setup similar models (but the jury is still out which approach is better).

The templates are being reviewed for better approaches in [Julia](http://julialang.org) vs. the current 'translated-from-Fortran' flavor. Examples of these kind of changes are to drop skyline storage and directly using Julia sparse matrices and replacing PtFEM's pair sparin() and spabac() by Julia's cholfact() and "\\" operation.

E.g. an example of this last change is replacing

```
  CSoM.sparin!(kv, kdiag)
  loads[2:end] = CSoM.spabac!(kv, loads[2:end], kdiag)
```

by

```
  cgsm = cholfact(gsm)
  loads[2:end] = cgsm \ loads[2:end]
```

in src/"4 Julia Static Equilibrium"/jFE4.1.jl. Note the "j" addition to template source file name.

All 'basic' functions such as sparin!() and spabac!() can be found in the src/CSoM directory. Note the use of the "!" in the function name which is the Julia convention for functions that update one or more of the function arguments. If specific Julia versions are required for use in the templates, these are added to the respective source files. Often times Julia's multiple dispatching takes care of selecting the correct version in the templates.

Again, while experimenting with the proper structure of the CSoM toolkit and at the same time trying to remain as compatible as possible with the primary documentation (the PtFEM book), I will store these Julia versions in corresponding subdirectories, e.g. in src/"4 Julia Static Equilibrium" for templates in src/"4 Static Equilibrium".

Fundamental and great development work related to solving (partial) differential equations is done in several other Julia packages, e.g. [ApproxFun.jl](https://github.com/JuliaApproximation/ApproxFun.jl), [DifferentialEquations.jl](https://github.com/JuliaDiffEq/DifferentialEquations.jl), [JuliaFEM.jl](http://www.juliafem.org) and  [JuaFEM.jl](https://github.com/KristofferC/JuAFEM.jl) to name a few.

Outside of Julia at least 2 other toolkits should be mentioned, i.e.  [deal.II](http://dealii.org) and [FEniCS](https://fenicsproject.org).

A companion package to [CSoM.jl](https://github.com/goedman/CSoM.jl), [NMfE.jl](https://github.com/goedman/NMfE.jl) based on [Numerical Methods for Engineers](https://books.google.com/books?id=lxGPQmuSwBQC&source=gbs_similarbooks) by I M Smith and D V Griffiths, is also under development but development work for this educational set of programs is happening on a slower pace as in my mind it should form a bridge to some of the above mentioned Julia packages related to solving differential equations. Note also the symbolic examples in chapter 7 of NMfE using the Julia Symata package.

Please note that no timeline is set when this work in progress will be finished.

Rob J Goedman
March 2017

References:

1. [Programming the Finite Element Method](http://www.wiley.com/WileyCDA/WileyTitle/productCd-1119973341.html)
1. [CSoM.jl](https://github.com/goedman/CSoM.jl)
1. [deal.II](http://dealii.org)
1. [FEniCS](https://fenicsproject.org)
1. [JuaFEM.jl](https://github.com/KristofferC/JuAFEM.jl)
1. [Julia language](http://julialang.org)
1. [ApproxFun.jl](https://github.com/JuliaApproximation/ApproxFun.jl)
1. [DifferentialEquations.jl](https://github.com/JuliaDiffEq/DifferentialEquations.jl)
1. [JuliaFEM.jl](http://www.juliafem.org)
1. [Numerical Methods for Engineers](https://books.google.com/books?id=lxGPQmuSwBQC&source=gbs_similarbooks)
1. [NMfE.jl](https://github.com/goedman/NMfE.jl)
1. [Symata.jl](https://github.com/jlapeyre/Symata.jl)