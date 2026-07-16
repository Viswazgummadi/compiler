```mermaid
flowchart TD

    A["1. User Source<br/>vectorAdd<<<blocks,threads>>>(a,b)"]

    A --> B["2. cudafe++<br/>Detect <<< >>>"]

    B --> C["3. Generate Stub<br/>foo.cudafe1.stub.c"]

    C --> D["4. Stub Function"]

    D --> E["5. Host Compiler (gcc)<br/>Compile Host + Stub"]

    E --> F["6. Object File<br/>vector_add.o"]

    F --> G["7. fatbinary<br/>Generate FATBIN"]

    G --> H["8. CUDA Registration<br/>__cudaRegisterFunction()"]

    H --> I["9. Executable"]

    subgraph SI["Stub Internals"]
        direction TB
        D1["__cudaPushCallConfiguration()"]
        D2["Pack Arguments<br/>void* __args[]"]
        D3["cudaLaunchKernel()"]

        D1 --> D2
        D2 --> D3
    end

    D -. contains .-> D1
