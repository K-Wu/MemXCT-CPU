# ----- Make Macros -----

# Works only for Amazon gravitron machine. Requires modification for other platforms.

CXX = mpicxx
CXXFLAGS = -std=c++11 -fopenmp -I/opt/amazon/openmpi/include/  
OPTFLAGS = -O3 -qopt-prefetch=0 -qopt-report=5 -qopt-report-file=$@.optrpt

LD_FLAGS = -fopenmp 

TARGETS = memxct
OBJECTS = src/main.o src/raytrace.o src/kernels.o

# ----- Make Rules -----

all:	$(TARGETS)

%.o: %.cpp vars.h
	${CXX} ${CXXFLAGS} ${OPTFLAGS} $^ -c -o $@

memxct: $(OBJECTS)
	$(CXX) -o $@ $(OBJECTS) $(LD_FLAGS)

clean:
	rm -f $(TARGETS) src/*.o src/*.o.* *.txt *.bin core
install:
	cp memxct $(PREFIX)/.
