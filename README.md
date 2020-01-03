Ceres Solver for IOS Platform(armv7 arm64 x86_64)
=================================================

This project is modified based on Ceres V2.0.0`master branch`(https://github.com/ceres-solver/ceres-solver)  
But original version is not supported for all solver methods and you may only use `DENSE_QR`.  
If you want to use some methods(ex.`SPARSE_SCHUR`) and you will find you can't use them.
So, I build this project and make sure it is supported for `suites-parse` and you can use it for all solvers(ex.trust_region_strategy or `SPARSE_NORMAL_CHOLESKY` and so on)!  

## What I change
Firstly, I add `Eigen3` source code and `Accelerate.framework` needed by libceres in `3rdParty` path.
Secondly, I modified both CMakeLists.txt under `root path` and `internal/ceres` to make sure cmake can find Eigen3 we added.

## How to Compile
Follow command below, and you will get libceres.a for IOS platform(armv7 arm64 x86_64) in `ios_build/`     
`cd 3rdParty/eigen3`   
`sh build.sh`   
and you will install Eigen3, and then   
`cd ../../ios_build`  
`sh build.sh`   
Finally, libceres.a will be saved.
