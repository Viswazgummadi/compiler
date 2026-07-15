```mermaid
graph TD
    A[1. User Source Code <br> vectorAdd<< < 1, 256 > >>] -->|cudafe++ frontend| B(2. The Surgery <br> .cudafe1.cpp)
    B -->|Calls| C[3. The Glue Code <br> .cudafe1.stub.c]
    
    %% The Stub Internals
    subgraph Stub Internals
        C -->|#includes| D(.fatbin.c <br> GPU Binary Array)
        C -->|Pushes args| E(__cudaLaunch)
    end
    
    %% The OS Boundary
    E -.->|Dynamic Link| F[4. CUDA Runtime <br> libcudart.so]
    F -.->|Calls| G[CUDA Driver <br> libcuda.so]
    G -.->|ioctl System Call| H(((Linux Kernel / Physical GPU)))
