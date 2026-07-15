## 🗺️ The Translation Flow

```mermaid
graph TD
    A[1. User Source Code <br> src/vector_add.cu] -->|Calls| B(2. Toolkit Headers <br> crt/device_functions.h)
    B -->|Tagged as| C{__device_builtin__}
    C -->|Bypasses standard linking| D[3. Closed-Source Compiler <br> cicc / NVVM]
    D -.->|Internal LLVM Mapping <br> NVPTXIntrinsics.td| E(@llvm.nvvm.barrier0)
    E -->|Translates to| F[4. GPU Assembly <br> intermediates/vector_add.ptx]
