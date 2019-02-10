#!/bin/sh
#pre-requisite: CUDA_HOME set to cuda installation, e.g., /usr/local/cuda
TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')

nvcc -shared  -D_USE_GPU_ -I/usr/include ../src/als.cu ../src/host_utilities.cpp ../src/cg.cu -o libALS.so \
-Xcompiler "-fPIC" -m64 -use_fast_math -rdc=true -gencode arch=compute_35,code=sm_35 -gencode arch=compute_35,code=compute_35 \
-O3 -Xptxas -dlcm=ca -L{$CUDA_HOME}/lib64 -lcublas -lcusparse

g++ -std=c++11 -shared als_tf.cc libALS.so -o als_tf.so -fPIC -I ${TF_INC} -L ${TF_LIB} -ltensorflow_framework


