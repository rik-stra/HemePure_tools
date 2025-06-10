#Module loads for Aurora
module load cmake
module load frameworks #Python

cd vx2gmy
#edit file to point to HemeLB path for tirpc
make
cd ..

cd gmy2lets
#edit Makefile to point to HemeLB path for tirpc
make gmy2lets
cd ..

#voxelizer...
#edited files - stored in palabosModified.tar.gz
#palabos/src/multiGrid/coarseGridProcessors3D.hh - line 160 -CHANGE indices.assign(indices.begin(), rhs.indices.begin(),rhs.indices.end());  TO indices.assign(rhs.indices.begin(),rhs.indices.end());
#palabos/src/offLattice/offLatticeBoundaryCondition3D.hh - line 105 - change rhs.offLatticeModel.clone() to (&(rhs.offLatticeModel))->clone() 
#palabos/src/offLattice/triangleBoundary3D.hh - line 1038 - change dynamic_cast<int> to dynamic_cast<VoxelFlagType>
#palabos/src/multiGrid/multiGridParameterManager.hh - line 44 - change ,originalParameters(rhs.parameters_) to ,originalParameters(rhs.originalParameters)
#
#These new files have been packed into palabosMOD.tar.gz
#The last three changes 'may' only be needed for llvm compilers like OneAPI. May be ok as original for GCC+MPI
#
#Have python3 available
#If SCons is not available e.g. as a module load, create a virtual environment in python3 (python3 -m venv [PATHTO]/VoxEnv --system-site-packages) and run 'pip install scons'

cd voxelizer/source
source venvs/VoxEnv/bin/activate #gets scons active, here run from HemePure_tools
make -f Makefile.frontier #this should work for Aurora too with the above. Change compiler to mpicxx 

#Ultimate compile instruction (should happen from the make instruction above):
#mpicxx -o voxelizer_MultiInput.o -c -Wall -Wno-unused-variable -Wnon-virtual-dtor -Wno-deprecated -std=c++11 -O3 -g -ggdb -DPLB_MPI_PARALLEL -DPLB_USE_POSIX -I/[PATHTO}/HemePure_tools/voxelizer/palabos/src -I/[PATHTO]/HemePure_tools/voxelizer/palabos/externalLibraries -I/[PATHTO]/HemePure_tools/voxelizer/palabos/externalLibraries/nanoflann voxelizer_MultiInput.cpp
