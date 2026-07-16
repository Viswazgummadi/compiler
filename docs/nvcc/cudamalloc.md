```mermaid
flowchart TD

    A["1. User Source<br/>cudaMalloc(&d_A, size)"]

    A --> B["2. Lexer.cpp<br/>tok::identifier"]

    B --> C["3. ParseExpr.cpp<br/>ParsePostfixExpressionSuffix()"]

    C --> D["4. SemaExpr.cpp<br/>Actions.ActOnCallExpr()"]

    D --> E["5. AST<br/>CallExpr"]

    E --> F["6. CGExpr.cpp<br/>EmitCallExpr()"]

    F --> G["7. LLVM IR<br/>call @cudaMalloc(...)"]

    G --> H["8. LLVM Backend"]

    H --> I["9. vector_add.o<br/>Undefined Symbol: cudaMalloc"]

    I --> J{"10. Linker (ld)"}

    K["libcudart.so<br/>Defines cudaMalloc"] -.-> J

    J --> L["11. Executable"]
