# p424: Compilers
### Team Members
Zach Sullivan
Gordon Lin

### Compile-able Language
Our typed language handles
* primitive arithmetic
* booleans and conditionals
* mutateable tuples called vectors
* functions
* lambdas (buggy)
* parametric polymorphism

### For Running and Testing
The `runtime.c` file needs to be compiled and linked with the assembly
code that your compiler produces. To compile `runtime.c`, do the
following

```
   gcc -c -g -std=c99 runtime.c
```
This will produce a file named `runtime.o`. The -g flag is to tell the
compiler to produce debug information that you may need to use
the gdb (or lldb) debugger.

To produce an executable program, you can then do

```
  gcc -g runtime.o foo.s
```
