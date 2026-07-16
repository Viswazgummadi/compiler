```mermaid
flowchart TD

    A["1. User Source<br/>__syncthreads()"]

    A --> B["2. CUDA Headers<br/>__builtin_ptx_bar_sync(0)"]

    B --> C["3. cicc<br/>Builtin Lookup"]

    C --> D["4. Internal IR<br/>Barrier Node"]

    D --> E["5. PTX<br/>bar.sync 0;"]

    E --> F["6. ptxas"]

    F --> G["7. CUBIN<br/>Barrier Instruction"]

    G --> H["8. GPU Execution"]
