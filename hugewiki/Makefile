# Location of the CUDA Toolkit
CUDA_PATH ?= /usr/local/cuda

HOST_COMPILER ?= g++
NVCC          := $(CUDA_PATH)/bin/nvcc -ccbin $(HOST_COMPILER)

# internal flags
NVCCFLAGS   := -std=c++11 --ptxas-options=-v #--maxrregcount 135

# Debug build flags
ifeq ($(dbg),1)
      NVCCFLAGS += -g -G
      TARGET := debug
else
      TARGET := release
endif

ALL_CCFLAGS :=
ALL_CCFLAGS += $(NVCCFLAGS)

ALL_LDFLAGS :=
ALL_LDFLAGS += $(ALL_CCFLAGS)

################################################################################

# Gencode arguments
SMS ?= 35

ifeq ($(GENCODE_FLAGS),)
# Generate SASS code for each SM architecture listed in $(SMS)
$(foreach sm,$(SMS),$(eval GENCODE_FLAGS += -gencode arch=compute_$(sm),code=sm_$(sm)))

# Generate PTX code from the highest SM architecture in $(SMS) to guarantee forward-compatibility
HIGHEST_SM := $(lastword $(sort $(SMS)))
ifneq ($(HIGHEST_SM),)
GENCODE_FLAGS += -gencode arch=compute_$(HIGHEST_SM),code=compute_$(HIGHEST_SM)
endif
endif

ALL_CCFLAGS += -rdc=true -Xptxas -dlcm=ca
LIBRARIES += -lcublas -lcusparse -lgomp 

################################################################################

# Target rules
all: build

build: hugewiki

hugewiki.o:hugewiki.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
hugewiki: hugewiki.o ../src/cg.o
	$(NVCC) $(ALL_LDFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ $+ $(LIBRARIES)
run: build
	./hugewiki
clean:
	rm -f hugewiki hugewiki.o
