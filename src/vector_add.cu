// src/vector_add.cu
#include <iostream>

// ---------------------------------------------------------
// PREPROCESSOR TRAP (To show them how Host/Device split works)
// ---------------------------------------------------------
#define VECTOR_SIZE 256

#ifdef __CUDA_ARCH__
    // This is injected ONLY when compiling for the GPU
    #define MULTIPLIER 2.0f
#else
    // This is injected ONLY when compiling for the CPU
    #define MULTIPLIER 1.0f
#endif

// ---------------------------------------------------------
// DEVICE CODE
// ---------------------------------------------------------
__global__ void vectorAdd(const float *a, const float *b, float *c) {
    int i = threadIdx.x + blockDim.x * blockIdx.x;
    __syncthreads();
    if (i < VECTOR_SIZE) {
        // We use the macro here. Which one will it be?
        c[i] = (a[i] + b[i]) * MULTIPLIER;
    }
}

// ---------------------------------------------------------
// HOST CODE
// ---------------------------------------------------------
int main() {
    // We use the macro here too.
    std::cout << "Starting NVCC Autopsy..." << std::endl;
    std::cout << "CPU Multiplier is: " << MULTIPLIER << std::endl;

    float *d_a, *d_b, *d_c;
    
    // THE KERNEL LAUNCH (We will watch this disappear)
    vectorAdd<<<1, VECTOR_SIZE>>>(d_a, d_b, d_c);

    return 0;
}
