```mermaid
flowchart TD

    A["1. CUDA Source (.cu)"]

    A --> B["2. Driver<br/>Split into Device & Host Pass"]

    %% Device Pass
    B --> C["3. Device Pass"]

    C --> D["4. Parse & Validate<br/>Device Code"]

    D --> E["5. Generate LLVM IR"]

    E --> F["6. Generate PTX"]

    F --> G["7. Generate CUBIN"]

    G --> H["8. Package into FATBIN"]

    %% Host Pass
    H --> I["9. Host Pass"]

    I --> J["10. Parse & Validate<br/>Host Code"]

    J --> K["11. Embed FATBIN<br/>Generate Kernel Stub"]

    K --> L["12. Generate Object File"]

    L --> M["13. Link CUDA Runtime"]

    M --> N["14. Executable"]
