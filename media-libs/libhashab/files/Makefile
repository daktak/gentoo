GCC=gcc

libhashhab.o: libhashab.so libhashab32_wrapper
	$(GCC) -shared -o libhashab.so libhashab.o

libhashab.so: libhashab.c
	$(GCC) -c -fpic libhashab.c

libhashab32_wrapper: libhashab32_wrapper.c 
	 $(GCC) -o libhashab32_wrapper libhashab32_wrapper.c -ldl -fno-stack-protector -m32

