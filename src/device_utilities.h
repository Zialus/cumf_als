#ifndef DEVICE_UTILITIES_H_
#define DEVICE_UTILITIES_H_
#define WARP_SIZE 32

#include <cuda.h>
#include <cuda_fp16.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>

#define FULL_MASK 0xffffffff

template<typename T>
inline __device__ T shfl_down(const T val, unsigned int delta) {
#if CUDA_VERSION >= 9000
    return __shfl_down_sync(FULL_MASK , val, delta);
#else
    return __shfl_down(val, delta);
#endif
}


//WARP shuffling code adopted from here:
//https://devblogs.nvidia.com/parallelforall/faster-parallel-reductions-kepler/
__inline__ __device__
float warpReduceSum(float val) {
    for (int offset = WARP_SIZE / 2; offset > 0; offset /= 2) {
        val += shfl_down(val, offset);
    }
    return val;
}

__inline__ __device__
float blockReduceSum(float* shared, float val) {
    //static __shared__ float shared[32]; // Shared mem for 32 partial sums
    int lane = threadIdx.x % WARP_SIZE;
    int wid = threadIdx.x / WARP_SIZE;
    val = warpReduceSum(val);     // Each warp performs partial reduction
#ifdef DEBUG
    //printf("warp id %d, lane %d, val: %f \n", wid, lane, val);
#endif
    //aggregate the zero thread in every wrap
    if (lane == 0) { shared[wid] = val; } // Write reduced value to shared memory
    __syncthreads();              // Wait for all partial reductions
    //read from shared memory only if that warp existed
    val = (threadIdx.x <= blockDim.x / WARP_SIZE) ? shared[lane] : 0;
    if (wid == 0) { val = warpReduceSum(val); } //Final reduce within first warp
#ifdef DEBUG
    //printf("RETURN block id %d, wid %d, lane %d, blockReduceSum: %f \n", blockIdx.x, wid, lane, val);
#endif
    return val;
}

__inline__ __device__
void blockReduceSumWithAtomics(float* out, float val) {
    int lane = threadIdx.x % WARP_SIZE;
    //printf("lane = %d\n", lane);
    val = warpReduceSum(val);     // Each warp performs partial reduction
    __syncthreads();
    if (lane == 0) {
#ifdef DEBUG
        //printf("--------------atomicAdd of %f in thread %d. \n", val,threadIdx.x);
#endif
        atomicAdd(out, val);
    }
}

__global__ void fp32Array2fp16Array(const float* fp32Array, half* fp16Array, int size);

__global__ void fp16Array2fp32Array(float* fp32Array, const half* fp16Array, int size);

#endif