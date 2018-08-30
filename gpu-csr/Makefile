CFLAGS = -std=c99 -fopenmp -g -Wall -Drestrict=__restrict__ -O3 -DNDEBUG -ffast-math -DGRAPH_GENERATOR_OMP # -g -pg
# CFLAGS = -g -Wall -Drestrict= -DGRAPH_GENERATOR_MPI
LDFLAGS = -fopenmp # -g -pg -G 
#NWARPS=1
CUDAFLAGS = -arch=$(CUDA_ARCH) -Xcompiler -fopenmp -O3 -Drestrict=__restrict__ -rdc=true # -g -pg -G #-DNWARPS=$(NWARPS)
INPUT=
CUDA_ARCH=sm_60
CUDA_LINK= -Xcompiler -fopenmp -arch=$(CUDA_ARCH)
EXEC = merrill romeo base romeo_multiGPU romeo_hypercube

all: $(EXEC)

GENERATOR_SOURCES = ../generator/graph_generator.o ../generator/make_graph.o \
		../generator/splittable_mrg.o ../generator/utils.o
GRAPH500_SOURCES = ../graph500.o ../options.o ../rmat.o ../kronecker.o ../verify.o \
		../prng.o ../xalloc.o ../timer.o

romeo_hypercube: $(GENERATOR_SOURCES) $(GRAPH500_SOURCES) bfs_romeo_hypercube.o 
	nvcc -o $@ $^ $(CUDA_LINK) $(INPUT) 

romeo_multiGPU: $(GENERATOR_SOURCES) $(GRAPH500_SOURCES) bfs_romeo_multiGPU.o 
	nvcc -o $@ $^ $(CUDA_LINK) $(INPUT) 

base: $(GENERATOR_SOURCES) $(GRAPH500_SOURCES) bfs_base.o 
	nvcc -o $@ $^ $(CUDA_LINK) $(INPUT)

romeo: $(GENERATOR_SOURCES) $(GRAPH500_SOURCES) bfs_romeo.o 
	nvcc -o $@ $^ $(CUDA_LINK) $(INPUT)

merrill: $(GENERATOR_SOURCES) $(GRAPH500_SOURCES) bfs_merrill.o 
	nvcc -o $@ $^ $(CUDA_LINK) $(INPUT)

%.o: %.cu 
	nvcc $(CUDAFLAGS) -c -o $@ $< $(INPUT)

%.o: %.c 
	$(CC) $(CFLAGS) -c -o $@ $< $(INPUT)

clean:
	-rm -f $(EXEC) *~ *.o *.a ../*.o ../generator/*.o
