CC = g++

#GSL_DIR = /home/post3/dev/
GSL_DIR = /shared-mounts/sinhas-storage1/experiment_valuation/packages/gsl-1.16/lib/
#/shared-mounts/sinhas/lib/gsl-1.8
#/Users/qiong/chunting/tools/gsl-1.15

INC = -I$(GSL_DIR) -I$(GSL_DIR)/include -I/usr/include -I/usr/local/include
CFLAGS = -g -O3 $(INC) -DStrongerSiteAttr=0 -DRandomGen=0

#CFLAGS = -O3 $(INC)

LIB_DIRS = -L$(GSL_DIR)/lib
LIBS = -lgsl -lgslcblas -lm
LFLAGS = -O3 $(LIB_DIRS) $(LIBS) -Wl,-rpath,$(GSL_DIR)/lib

BIN = seq2binding 

all: $(BIN)

clean:
	rm -f $(BIN)

Tools.o : Tools.h Tools.cpp
	$(CC) $(CFLAGS) -c Tools.cpp
SeqAnnotator.o : Tools.h SeqAnnotator.h SeqAnnotator.cpp
	$(CC) $(CFLAGS) -c SeqAnnotator.cpp
BindingPredictor.o : Tools.h SeqAnnotator.h BindingPredictor.h BindingPredictor.cpp
	$(CC) $(CFLAGS) -c BindingPredictor.cpp
seq2binding.o : Tools.h SeqAnnotator.h BindingPredictor.h seq2binding.cpp
	$(CC) $(CFLAGS) -c seq2binding.cpp

seq2binding : Tools.o SeqAnnotator.o BindingPredictor.o seq2binding.o
	$(CC) $(LFLAGS) -o $@ Tools.o SeqAnnotator.o BindingPredictor.o seq2binding.o
