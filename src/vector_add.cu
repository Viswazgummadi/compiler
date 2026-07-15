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
    cudaMalloc((void**)&d_a, VECTOR_SIZE * sizeof(float));
    // THE KERNEL LAUNCH (We will watch this disappear)
    vectorAdd<<<1, VECTOR_SIZE>>>(d_a, d_b, d_c);

    return 0;
}


/*
int main() {
    std::cout << "Starting NVCC Autopsy..." << std::endl;
    std::cout << "CPU Multiplier is: " << MULTIPLIER << std::endl;

    // Host arrays
    float h_a[VECTOR_SIZE];
    float h_b[VECTOR_SIZE];
    float h_c[VECTOR_SIZE];

    // Initialize host data
    for (int i = 0; i < VECTOR_SIZE; i++) {
        h_a[i] = static_cast<float>(i);
        h_b[i] = static_cast<float>(i * 2);
    }

    // Device pointers
    float *d_a, *d_b, *d_c;

    // Allocate GPU memory
    cudaMalloc(&d_a, VECTOR_SIZE * sizeof(float));
    cudaMalloc(&d_b, VECTOR_SIZE * sizeof(float));
    cudaMalloc(&d_c, VECTOR_SIZE * sizeof(float));

    // Copy input data to GPU
    cudaMemcpy(d_a, h_a,
               VECTOR_SIZE * sizeof(float),
               cudaMemcpyHostToDevice);

    cudaMemcpy(d_b, h_b,
               VECTOR_SIZE * sizeof(float),
               cudaMemcpyHostToDevice);

    // Launch kernel
    vectorAdd<<<1, VECTOR_SIZE>>>(d_a, d_b, d_c);

    // Wait for kernel to finish
    cudaDeviceSynchronize();

    // Copy results back to CPU
    cudaMemcpy(h_c, d_c,
               VECTOR_SIZE * sizeof(float),
               cudaMemcpyDeviceToHost);

    // Print a few results
    std::cout << "\nResults:\n";
    for (int i = 0; i < 10; i++) {
        std::cout << "C[" << i << "] = " << h_c[i] << std::endl;
    }

    // Free GPU memory
    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}

*/
