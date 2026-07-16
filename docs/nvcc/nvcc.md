```mermaid
flowchart TD

    A["foo.cu"]

    A --> B["1. Preprocessor (gcc -E)"]
    B --> C["Host: foo.cpp4.ii"]
    B --> D["Device: foo.cpp1.ii"]

    D --> E["2. cudafe++"]
    E --> F["foo.cudafe1.gpu"]

    C --> E
    E --> G["foo.cudafe1.stub.c"]

    F --> H["3. cicc"]
    H --> I["PTX (foo.ptx)"]

    I --> J["4. ptxas"]
    J --> K["CUBIN (foo.sm_80.cubin)"]

    K --> L["5. fatbinary"]
    I --> L
    L --> M["FATBIN (foo.fatbin)"]

    G --> N["6. gcc"]
    M --> N
    N --> O["Object File (foo.o)"]

    O --> P["7. Linker (ld/gcc)"]
    Q["CUDA Runtime (libcudart)"] --> P
    P --> R["Executable (foo)"]
