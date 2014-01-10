MINI_PROJECT Directory contains:
================================

* this readme file (README.txt)
* The mini-project report (report.pdf)
* examples of compiled tool programs (examples/)

N.B. Only a few examples are provided in compiled form but all Tool programs
from the programs/ folder should work.

Example compiled tool program
=============================
In each example directory, you will find:

* the tool source code
* its compiled LLVM-IR version for Linux 64 bits (obtained by our back-end)
* an executable binary (Linux 64 bits)
* an html page executing tool code in javascript using emscripten (all OSes)

Compile Tool to LLVM-IR
=======================
Use our compiler to compile "program.tool" to "program.ll"

Compile LLVM-IR to native code
==============================
Use "clang" compiler or "llc" (LLVM compiler)

  => clang program.ll -o program
  => llc program.ll -o program 

emscriten: Compile LLVM-IR to Javascript
========================================
emscripten is a LLVM-IR to javascript compiler. To use it, first download and
install it and then:

 => emcc program.ll -o program.html


