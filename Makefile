# Makefile

# The CUDA Compiler Driver
NVCC = nvcc

# Architecture target (Adjust if needed, sm_80 is Ampere / RTX 30-series)
ARCH = -arch=sm_80

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

clean:
	rm -rf intermediates/* trace_logs/* $(EXE)
