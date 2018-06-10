#!/bin/bash -uxe


case ${CUDA:0:3} in

'7.0')  installer="http://developer.download.nvidia.com/compute/cuda/7_0/Prod/network_installers/cuda_7.0.29_mac_network.dmg";;
'7.5')  installer="http://developer.download.nvidia.com/compute/cuda/7.5/Prod/network_installers/cuda_7.5.27_mac_network.dmg";;
'8.0')  installer="https://developer.nvidia.com/compute/cuda/8.0/Prod2/network_installers/cuda_8.0.61_mac_network-dmg";;
'9.0')  installer="https://developer.nvidia.com/compute/cuda/9.0/Prod/network_installers/cuda_9.0.176_mac_network-dmg";;
'9.1')  installer="https://developer.nvidia.com/compute/cuda/9.1/Prod/network_installers/cuda_9.1.128_mac_network";;
'9.2')  installer="https://developer.nvidia.com/compute/cuda/9.2/Prod/network_installers/cuda_9.2.64_mac_network";;

esac

wget -O cuda.dmg "$installer"

hdiutil attach cuda.dmg
sudo /Volumes/CUDAMacOSXInstaller/CUDAMacOSXInstaller.app/Contents/MacOS/CUDAMacOSXInstaller --accept-eula --no-window
hdiutil detach /Volumes/CUDAMacOSXInstaller

export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=${CUDA_HOME}/nvvm/lib64:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}
export PATH=${CUDA_HOME}/bin:${PATH}