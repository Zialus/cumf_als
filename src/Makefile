# Location of the CUDA Toolkit
CUDA_PATH ?= /usr/local/cuda

HOST_COMPILER ?= g++
NVCC          := $(CUDA_PATH)/bin/nvcc -ccbin $(HOST_COMPILER)

# internal flags
NVCCFLAGS   := -std=c++11 --ptxas-options=-v #--maxrregcount 255

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

build: main
debug: clean
debug: ALL_CCFLAGS+=-DDEBUG
debug: build 

als.o:als.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
cg.o:cg.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
main.o:main.cpp
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
host_utilities.o:host_utilities.cpp
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
device_utilities.o:device_utilities.cu
	$(NVCC) $(INCLUDES) $(ALL_CCFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ -c $<
main: host_utilities.o device_utilities.o cg.o als.o main.o
	$(NVCC) $(ALL_LDFLAGS) $(GENCODE_FLAGS) -lineinfo -o $@ $+ $(LIBRARIES)
#netflix
run: main
	 ./main 17770 480189 100 99072112 1408395 0.048 1 3 ./data/netflix/
clean:
	rm -f host_utilities.o device_utilities.o als.o main main.o cg.o
