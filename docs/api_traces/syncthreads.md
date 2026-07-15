# 🔍 API Trace: The `__syncthreads()` Lifecycle

> **Objective:** Trace a device-side CUDA API call from the user's C++ source code down to the bare-metal virtual assembly, exposing the compiler's internal LLVM mapping.

Unlike standard CPU functions, device built-ins like `__syncthreads()` do not have corresponding `.cpp` source files containing their logic. Instead, they are intrinsic triggers mapped directly into hardware instructions by the compiler backend.

## 🧬 1. The Translation Pipeline

This flowchart shows the exact descent from high-level C++ to raw PTX assembly.

```mermaid
graph TD
    classDef code fill:#1e1e1e,stroke:#333,stroke-width:2px,color:#d4d4d4,font-family:monospace;
    classDef header fill:#2b3a42,stroke:#4a6984,stroke-width:2px,color:#fff;
    classDef compiler fill:#422b2b,stroke:#844a4a,stroke-width:2px,color:#fff;
    
    A["1. User Source Code<br><br>__syncthreads();"]:::code
    B["2. CUDA Header (device_functions.h)<br><br>__device_builtin__ void __syncthreads(void);"]:::header
    
    A --> B
    
    subgraph The Black Box (cicc / NVVM)
    C["3. Frontend Parser<br><br>Detects '__device_builtin__'<br>Skips standard C++ linking"]:::compiler
    D["4. LLVM Intermediate Representation (IR)<br><br>call void @llvm.nvvm.barrier0()"]:::code
    E["5. Instruction Selection (Backend)<br><br>Searches NVPTX Dictionary"]:::compiler
    
    B --> C
    C --> D
    D --> E
    end
    
    F["6. PTX Assembly Output (.ptx)<br><br>bar.sync 0;"]:::code
    G["7. PTX Assembler (ptxas)<br><br>Final SASS Binary (1s and 0s)"]:::header
    
    E --> F
    F --> G
