MPICC=mpicxx#/opt/cray/craype/2.5.8/bin/CC

codedir = [HemePureFolderLocation]
CFLAGS = -I/$(codedir)/HemePure/dep/install/include/tirpc
LFLAGS = -L/$(codedir)/HemePure/dep/install/lib/

mpivx2gmy: mpivx2gmy.cc
	$(MPICC) -O3 $(CFLAGS) -Wall -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -std=c++11 mpivx2gmy.cc -o mpivx2gmy -lz $(LFLAGS) -ltirpc

debug: mpivx2gmy.cc
	$(MPICC) -O0 -g -Wall -D_LARGEFILE_SOURCE=1 -D_FILE_OFFSET_BITS=64 -std=c++11 mpivx2gmy.cc -lz -o mpivx2gmy
