```mermaid
flowchart TD

    A["1. User Source<br/>__syncthreads()"]

    A --> B["2. __clang_cuda_intrinsics.h<br/>__nvvm_barrier0()"]

    B --> C["3. BuiltinsNVPTX.def<br/>BUILTIN(__nvvm_barrier0)"]

    C --> D["4. ParseExpr.cpp<br/>ParsePostfixExpressionSuffix()"]

    D --> E["5. Sema<br/>Actions.ActOnCallExpr()"]

    E --> F["6. AST<br/>CallExpr"]

    F --> G["7. CGBuiltin.cpp<br/>EmitNVPTXBuiltinExpr()"]

    G --> H["8. LLVM IR<br/>@llvm.nvvm.barrier0()"]

    H --> I["9. LLVM Backend (ISel)<br/>Uses NVPTXIntrinsics.td"]

    I --> J["10. Machine Instructions<br/>bar.sync 0;"]

    J --> K["11. NVPTXAsmPrinter.cpp<br/>Emit PTX"]

    K --> L["12. PTX<br/>bar.sync 0;"]
