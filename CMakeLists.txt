cmake_minimum_required(VERSION 3.9)
project(cumf_als)

set(CMAKE_CXX_STANDARD 11)

#set(CMAKE_VERBOSE_MAKEFILE ON)

#set(CUDA_SEPARABLE_COMPILATION ON)

find_package(CUDA REQUIRED)
find_package(OpenMP REQUIRED)

set(EXECUTABLE_OUTPUT_PATH "${CMAKE_SOURCE_DIR}/exec/")

# Extra warning flags only during nvcc compilation
#if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
#    set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} "-Xcompiler -Wall, -Wextra")
#elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
#    set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} "-Xcompiler -Weverything")
#endif ()

set(EXTRA_NVCC_FLAGS -arch=sm_35 -Xptxas -dlcm=ca --std=c++11)

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS} ${EXTRA_NVCC_FLAGS})

# Extra warning flags during compilation
#if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -pedantic")
#elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
#    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Weverything")
#endif ()

#set(WARNINGS "-Wno-missing-prototypes")
#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${WARNINGS}")


file(GLOB src "${PROJECT_SOURCE_DIR}/*.cpp" "${PROJECT_SOURCE_DIR}/*.c")
file(GLOB hdr "${PROJECT_SOURCE_DIR}/*.hpp" "${PROJECT_SOURCE_DIR}/*.h")
file(GLOB cuda "${PROJECT_SOURCE_DIR}/*.cu")

CUDA_ADD_EXECUTABLE(cumf_als ${src} ${hdr} ${cuda})
target_link_libraries(cumf_als OpenMP::OpenMP_CXX ${CUDA_CUBLAS_LIBRARIES} ${CUDA_cusparse_LIBRARY})
