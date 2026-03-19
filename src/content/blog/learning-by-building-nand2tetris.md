---
title: The Nand2tetris Experience
date: '2024-03-01'
description: Building a computer from NAND gates up through hardware, assembler, VM, compiler, and OS.
---

# Learning by Building: The Nand2tetris Experience

The Nand2tetris project has you build a complete computer system from the ground up, starting with NAND gates and ending with a compiler and operating system.

Hardware layer: NAND gates combine into more complex gates (AND, OR, NOT), which combine into adders and multiplexers, which combine into an ALU. Memory is built from flip-flops organized into registers and RAM. The CPU ties it all together - fetching instructions, decoding them, and executing operations. Building this in a hardware simulator makes the connections between logic and computation concrete.

Assembler: Machine code is just bytes, which is hard to read and write. The assembler converts assembly mnemonics to machine code. It handles labels, so you can write `@LOOP` instead of calculating addresses manually. It handles pseudo-commands that get translated into multiple machine instructions.

Virtual Machine: The VM defines a stack-based intermediate language. High-level code compiles to VM commands, and the VM executes those commands. This abstraction layer separates compilation from the underlying machine. Stack operations push and pop values, arithmetic operations consume stack values, and control flow operations jump to labels.

Compiler: A Jack-like high-level language compiles to VM code. The compiler parses source code, builds an AST, and generates VM commands. It handles expressions, statements, function calls, and classes. Two-stage compilation - parsing then code generation - makes the problem manageable.

Operating System: A minimal OS provides math functions, string handling, and I/O operations. These are libraries that VM programs can call. The OS bridges the gap between the raw VM and useful functionality.

Each layer builds on the previous one. The hardware executes the machine code from the assembler. The VM code runs on the VM. The high-level language compiles to VM code. The OS provides services to high-level programs. Building the entire stack gives you perspective on how computers work at every level.
