# Makefile

# Compilers
NVCC = nvcc
CLANG = clang++

# Architectures (Adjust if needed, sm_80 is Ampere)
NVCC_ARCH = -arch=sm_80
CLANG_ARCH = --cuda-gpu-arch=sm_80

# Source and outputs
SRC = src/vector_add.cu
EXE_NVCC = bin/vector_add_nvcc
EXE_LLVM = bin/vector_add_llvm

.PHONY: all clean trace_nvcc keep_nvcc trace_llvm keep_llvm

all: all_nvcc all_llvm

# ==========================================
# NVCC TARGETS
# ==========================================
all_nvcc:
	@mkdir -p bin
	$(NVCC) $(NVCC_ARCH) $(SRC) -o $(EXE_NVCC)
	@echo "✅ NVCC build complete."

trace_nvcc:
	@mkdir -p trace_logs/nvcc
	$(NVCC) $(NVCC_ARCH) --dryrun $(SRC) 2> trace_logs/nvcc/dryrun_log.txt
	@echo "✅ NVCC Trace saved to trace_logs/nvcc/dryrun_log.txt"

keep_nvcc:
	@mkdir -p intermediates/nvcc bin
	$(NVCC) $(NVCC_ARCH) --keep --keep-dir intermediates/nvcc $(SRC) -o $(EXE_NVCC)
	@echo "✅ NVCC Intermediates saved in intermediates/nvcc/"

# ==========================================
# LLVM (CLANG) TARGETS
# ==========================================
all_llvm:
	@mkdir -p bin
	$(CLANG) $(CLANG_ARCH) $(SRC) -o $(EXE_LLVM)
	@echo "✅ LLVM build complete."

trace_llvm:
	@mkdir -p trace_logs/llvm
	$(CLANG) $(CLANG_ARCH) -### $(SRC) > trace_logs/llvm/dryrun_log.txt 2>&1
	@echo "✅ LLVM Trace saved to trace_logs/llvm/dryrun_log.txt"

keep_llvm:
	@mkdir -p intermediates/llvm bin
	@echo "💾 Compiling with Clang and saving temps..."
	$(CLANG) $(CLANG_ARCH) -save-temps -o $(EXE_LLVM) $(SRC)
	@echo "🚚 Moving intermediate files to intermediates/llvm/..."
	@mv vector_add*.* intermediates/llvm/ 2>/dev/null || true
	@echo "✅ LLVM Intermediates saved in intermediates/llvm/"

# ==========================================
# CLEAN
# ==========================================
clean:
	rm -rf intermediates/nvcc/* intermediates/llvm/* trace_logs/nvcc/* trace_logs/llvm/* bin/*
	@echo "🧹 Workspace cleaned."
