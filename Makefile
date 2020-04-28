GCC = gcc
EXE = main.exe

LINK = ${GCC}
CPPFLAGS = -Wall -O3 
LDFLAGS = 

LIB = testfn
LIB_SRC = $(LIB).c
LIB_STATIC = $(LIB).a
LIB_SHARED = $(LIB).so
EXE_1 = $(EXE).static
EXE_2 = $(EXE).dynamic
EXE_3 = $(EXE).inline

build: $(EXE_1) $(EXE_2) $(EXE_3)

$(LIB_SHARED): ./src/$(LIB_SRC)
	$(GCC) $(CPPFLAGS)  $^ -c -o $^.so
	$(GCC) -fPIC -shared $^.so -o lib$@ 

$(LIB_STATIC): ./src/$(LIB_SRC)
	$(GCC) $(CPPFLAGS) $^ -c -o $^.o
	ar -cvq $@ $^.o
	ranlib $@

$(EXE_1): ./src/fnbench.c $(LIB_STATIC)
	$(GCC) $(CPPFLAGS)  -o $@ $^

$(EXE_2): ./src/fnbenchso.c $(LIB_SHARED)
	$(GCC) $(CPPFLAGS) -L./ ./src/fnbenchso.c -o $@ -l$(LIB)

$(EXE_3): ./src/fnbenchinl.c
	$(GCC) $(CPPFLAGS) $^ -o $@
clean: 
	rm -f *.o *.exe.* *.so *.a
