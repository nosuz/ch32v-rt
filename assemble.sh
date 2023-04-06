#!/bin/bash

set -euxo pipefail

crate=ch32v-rt

# remove existing blobs because otherwise this will append object files to the old blobs
rm -f bin/*.a

# QingKe V3 on CH32V103 is RV32IMAC ISA and doesn't support Supervisor mode.
ext='imc'
abi=''

# sudo apt install gcc-riscv64-unknown-elf
riscv64-unknown-elf-gcc -ggdb3 -fdebug-prefix-map=$(pwd)=/riscv-rt -c -mabi=ilp32${abi} -march=rv32${ext} asm.S -o bin/$crate.o
riscv64-unknown-elf-ar crs bin/riscv32${ext}-unknown-none-elf.a bin/$crate.o

rm bin/$crate.o
