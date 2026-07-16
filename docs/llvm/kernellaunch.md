```mermaid
flowchart TD

    A["1. User Source<br/>vectorAdd<<<blocks,threads>>>(a,b)"]

    A --> B["2. Lexer.cpp<br/>tok::lesslessless"]

    B --> C["3. ParseExpr.cpp<br/>ParseCUDAExecutionConfig()"]

    C --> D["4. SemaCUDA.cpp<br/>CUDAKernelCallExpr"]

    D --> E["5. AST<br/>CUDAKernelCallExpr"]

    E --> F["6. CGCUDARuntime.cpp<br/>EmitCUDAKernelCallExpr()"]

    F --> G["7. LLVM IR<br/>__cudaPushCallConfiguration()"]

    G --> H["8. CGCUDANV.cpp<br/>emitDeviceStubBodyNew()"]

    H --> I["9. LLVM IR<br/>cudaLaunchKernel()"]

    I --> J["10. LLVM Backend"]

    J --> K["11. Object File<br/>vector_add.o"]

    K --> L["12. makeModuleCtorFunction()<br/>Embed FATBIN"]

    L --> M["13. __cudaRegisterFatBinary()<br/>__cudaRegisterFunction()"]

    M --> N["14. Executable"]
