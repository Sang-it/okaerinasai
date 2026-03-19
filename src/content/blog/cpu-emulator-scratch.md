---
title: Building a CPU Emulator from Scratch
date: '2024-02-20'
description: NES emulator project and understanding the 6502 CPU and PPU.
---

# Building a CPU Emulator from Scratch

I built a NES emulator to understand how computers work at the hardware level. It implements the 6502 CPU and the Picture Processing Unit (PPU).

The 6502 is an 8-bit processor with a small instruction set, but it has quirks that matter for correct emulation. Each instruction takes a specific number of cycles, and some instructions take longer depending on addressing mode. The NES relies on precise timing - if your CPU cycles are off, games will glitch or not run at all. I implemented a cycle counter that advances after each instruction execution.

Memory mapping is another detail that matters. The 6502 has 64KB of address space, but the NES maps different hardware to different addresses. RAM is at $0000-$07FF, PPU registers at $2000-$2007, and the cartridge can map ROM and RAM into various address ranges. The emulator needs to handle these mappings correctly.

The PPU is more complex than the CPU. It renders 256x240 pixels, manages sprites and backgrounds, and handles scrolling. It has its own memory (pattern tables, name tables, palettes) that the CPU accesses through registers. Scanline rendering means the PPU draws one line at a time, and the CPU can modify graphics during specific scanlines to create effects.

Implementing sprite handling required understanding the NES's sprite memory (OAM) and how the PPU prioritizes and draws 8 sprites per scanline. Background rendering uses name tables that define which tile goes where, with scrolling implemented through an internal scroll register.

Getting a test ROM to run was a milestone. The CPU executing instructions correctly, the PPU rendering pixels, and the whole system running in sync - it took iteration and debugging, but eventually the NES booted and games played.

Emulation teaches you about hardware-software interactions. Every instruction has a cost, every memory access goes somewhere specific, and timing matters in ways that don't affect high-level code.
