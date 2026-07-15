```mermaid
graph TD
    %% Source and Header
    A[1. User Source Code <br> cudaMalloc] -->|Parsed by| C(3. Host Compiler <br> gcc)
    B[2. The Contract <br> cuda_runtime_api.h] -.->|extern declaration| C
    
    %% Compilation to Object
    C -->|Compiles to| D[4. The Placeholder <br> vector_add.o]
    
    %% Linking Phase
    D -->|Unresolved Symbol: cudaMalloc| F{5. The Linker <br> ld}
    E[Closed-Source Binary <br> libcudart.so / .a] -.->|Exports Symbol: cudaMalloc| F
    
    %% Final Executable
    F -->|Link-Time Binding| G(((6. Final Executable <br> a.out)))
