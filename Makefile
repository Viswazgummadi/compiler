# Makefile

# The CUDA Compiler Driver
NVCC = nvcc

# Architecture target (Adjust if needed, sm_80 is Ampere / RTX 30-series)
# Old:
ARCH = -arch=sm_80

# New: The Professional Deployment Flags
# 1. Compile SASS (Machine Code) for Volta (sm_70)
# 2. Compile SASS (Machine Code) for Ampere (sm_80)
# 3. Embed PTX (Virtual Assembly) for compute_80 (Forward compatibility for future GPUs)
#ARCH = \
 # -gencode arch=compute_70,code=sm_70 \
  #-gencode arch=compute_80,code=sm_80 \
  #-gencode arch=compute_80,code=compute_80


# Source and output
SRC = src/vector_add.cu
EXE = vector_add

# Targets
.PHONY: all clean trace keep

# Standard build
all:
	$(NVCC) $(ARCH) $(SRC) -o $(EXE)
	@echo "✅ Standard build complete."

# THE TRACE: Runs a dry-run and pipes the shell commands into a log file
trace:
	@mkdir -p trace_logs
	@echo "🔍 Running nvcc in dry-run mode..."
	# Note: nvcc --dryrun prints to stderr (>&2), so we redirect 2> to our log file
	$(NVCC) $(ARCH) --dryrun $(SRC) 2> trace_logs/dryrun_log.txt
	@echo "✅ Trace saved to trace_logs/dryrun_log.txt"

# THE KEEP: Forces nvcc to keep every single intermediate file it generates
keep:
	@mkdir -p intermediates
	@echo "💾 Running nvcc and preserving all intermediate files..."
	$(NVCC) $(ARCH) --keep --keep-dir intermediates $(SRC) -o $(EXE)
	@echo "✅ Intermediates saved in intermediates/ directory."

# THE PROFILER: Passing flags to the PTX assembler
inspect:
	@echo "🔬 Compiling and inspecting GPU hardware usage..."
	$(NVCC) $(ARCH) src/vector_add.cu -Xptxas -v -o $(EXE)

clean:
	rm -rf intermediates/* trace_logs/* $(EXE)
