---
title: Operating Systems Development with xv6
date: '2026-01-05'
description: Extending xv6-riscv and learning about kernel development.
---

# Operating Systems Development with xv6

xv6 is a teaching operating system based on early Unix, implemented in a few thousand lines of C. I extended it to understand kernel development and systems programming.

xv6 provides the fundamentals: process management, virtual memory, file systems, inter-process communication, and system calls. The code is small enough to read in its entirety, which makes the connections between components visible. You can trace a system call from user space through the kernel to hardware, understanding each step along the way.

Processes in xv6 have their own virtual address spaces. The kernel maps physical pages to virtual addresses, creating the illusion of each process having its own memory. Page tables handle this mapping. When a process switches context, the kernel switches page tables, so the new process sees its own memory. Context switching saves and restores registers so execution can resume where it left off.

The file system xv6 uses is simple: files are collections of blocks, directories are special files that contain file entries. The inode layer manages file metadata and block allocation. The buffer cache caches disk blocks in memory to avoid slow disk accesses. Extending the file system means understanding how these layers interact.

System calls are the bridge between user programs and the kernel. When a user program calls a system call, it triggers a trap into kernel mode. The kernel identifies the system call number, executes the corresponding handler, and returns results to user space. The system call interface is the set of operations the kernel exposes.

I extended xv6 by adding new system calls and modifying existing components. This involved understanding the calling convention, how arguments are passed, and how errors are reported. It also required attention to concurrency - multiple processes can call the same system call simultaneously, so locks are necessary.

Kernel debugging is challenging. You can't use user-space debuggers easily. Printf-style logging is common, but the kernel can't print before console drivers are initialized. Sometimes you have to examine memory dumps or add instrumentation to understand what's happening.

Working with xv6 shows how operating systems implement abstractions that we take for granted. Files are block allocations. Processes are memory mappings and saved state. System calls are trap handlers. Seeing the concrete implementation makes these abstractions less mysterious.
