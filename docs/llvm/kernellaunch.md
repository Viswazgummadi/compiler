```mermaid
flowchart TD

    A["1. User Source<br/>vectorAdd<<<blocks,threads>>>(a,b)"]

    A --> B["2. Lexer.cpp<br/>tok::lesslessless"]

    B --> C["3. ParseExpr.cpp<br/>ParseCUDAExecutionConfig()"]

    C --> D["4. SemaCUDA.cpp<br/>CUDAKernelCallExpr<br/>↓<br/>AST: CUDAKernelCallExpr"]

    D --> E["5. CGCUDARuntime.cpp<br/>EmitCUDAKernelCallExpr()"]

    E --> F["6. CGCUDANV.cpp<br/>emitDeviceStubBodyNew()"]

    F --> G["7. LLVM IR<br/>Push Launch Config<br/>Pack Kernel Arguments<br/>cudaLaunchKernel()"]

    G --> H["8. makeModuleCtorFunction()<br/>Embed FATBIN + Generate Constructor"]

    H --> I["9. LLVM Backend"]

    I --> J["10. Object File<br/>vector_add.o"]

    J --> K["11. Linker"]

    K --> L["12. Executable"]

    L -. Program Starts .-> M["13. Execute Constructors<br/>Map Stub → GPU Kernel"]
