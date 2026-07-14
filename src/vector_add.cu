#include <iostream>

#define VECTOR_SIZE 256

// Part 1: Device Code
__global__ void vectorAdd(const float *a, const float *b, float *c) {
    int i = threadIdx.x + blockDim.x * blockIdx.x;
    if (i < VECTOR_SIZE) {
        c[i] = a[i] + b[i];
    }
}

// Part 2: Host Code
int main() {
    std::cout << "Starting NVCC Autopsy Vector Add..." << std::endl;

    float *d_a, *d_b, *d_c;

    // Part 3: Kernel Launch
    vectorAdd<<<1, 256>>>(d_a, d_b, d_c);

    return 0;
}
