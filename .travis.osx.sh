#!/bin/bash

brew update
brew cask uninstall oclint
brew install llvm@5 && brew link --overwrite llvm@5 --force
export CC=clang-5.0
export CXX=clang++
wget https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_${CUDA}_mac
hdiutil attach cuda_9.2.64_mac
sudo /Volumes/CUDAMacOSXInstaller/CUDAMacOSXInstaller.app/Contents/MacOS/CUDAMacOSXInstaller --accept-eula --no-window
hdiutil detach /Volumes/CUDAMacOSXInstaller
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=${CUDA_HOME}/nvvm/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
export PATH=${CUDA_HOME}/bin:${PATH}