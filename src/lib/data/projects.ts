export interface Project {
  name: string;
  description: string;
  language: string;
  url: string;
  stars?: number;
  featured?: boolean;
  tags?: string[];
}

export const projects: Project[] = [
  {
    name: "memory",
    description:
      "Your memories, reimagined. A personal memory management application built in Rust.",
    language: "Rust",
    url: "https://github.com/enfinyte/memory",
    featured: true,
    tags: ["rust", "application"],
  },
  {
    name: "router",
    description:
      "An LLM routing platform for intelligently distributing requests across language model providers.",
    language: "TypeScript",
    url: "https://github.com/enfinyte/router",
    featured: true,
    tags: ["llm", "routing", "ai-infrastructure"],
  },
  {
    name: "evenscribe-collector",
    description:
      "Log collector for the Evenscribe logging infrastructure. Ingests, processes, and forwards logs to ClickHouse.",
    language: "C++",
    url: "https://github.com/enfinyte/evenscribe-collector",
    featured: true,
    tags: ["observability", "logging", "clickhouse"],
  },
  {
    name: "fluoride",
    description:
      "Neovim plugin that lets you view, reorder, and rename top-level code declarations through a floating window. Powered by Treesitter and LSP.",
    language: "Lua",
    url: "https://github.com/Sang-it/fluoride",
    featured: true,
    tags: ["neovim", "treesitter", "lsp", "developer-tools"],
  },
  {
    name: "nes_emulator",
    description:
      "NES emulator written in Rust. Emulates the 6502 CPU, PPU, and cartridge mapper hardware.",
    language: "Rust",
    url: "https://github.com/Sang-it/nes_emulator",
    featured: true,
    tags: ["emulation", "systems-programming", "6502"],
  },
  {
    name: "wave",
    description:
      "Multi-paradigm programming language implemented in Rust. Supports both functional and imperative styles.",
    language: "Rust",
    url: "https://github.com/Sang-it/wave",
    featured: true,
    tags: ["language-design", "interpreter", "compiler"],
  },
  {
    name: "neural_engine",
    description:
      "Neural network engine built from scratch using only NumPy. CS 499 Independent Study project.",
    language: "Python",
    url: "https://github.com/Sang-it/neural_engine",
    featured: true,
    tags: ["machine-learning", "neural-networks", "numpy"],
  },
  {
    name: "nand2tetris",
    description:
      "A complete computer built from NAND gates up through hardware, assembler (Scala), VM (C++), compiler (Elixir, C#/ANTLR), and OS.",
    featured: true,
    language: "Scala / C++ / Elixir / C#",
    url: "https://github.com/Sang-it/nand2tetris",
    tags: ["computer-architecture", "hardware", "from-scratch"],
  },
  {
    name: "strings",
    description:
      "Parser generator written in Rust for building custom parsers from grammar definitions.",
    language: "Rust",
    url: "https://github.com/Sang-it/strings",
    tags: ["parsing", "code-generation", "compilers"],
  },
  {
    name: "scheme._.",
    description:
      "Functional programming language interpreter written in Haskell, implementing a Scheme dialect.",
    language: "Haskell",
    featured: true,
    url: "https://github.com/Sang-it/scheme._.",
    tags: ["functional-programming", "interpreter", "scheme"],
  },
  {
    name: "t_rex",
    description:
      "NFA/DFA-based regex engine built in TypeScript. Implements Thompson's construction and subset construction algorithms.",
    language: "TypeScript",
    url: "https://github.com/Sang-it/t_rex",
    tags: ["automata", "regex", "formal-languages"],
  },
  {
    name: "brainfuck",
    description: "Brainfuck interpreter implemented in Haskell with parsing and evaluation.",
    language: "Haskell",
    url: "https://github.com/Sang-it/brainfuck",
    tags: ["esoteric-languages", "interpreter"],
  },
  {
    name: "json-parser",
    description: "JSON parser written in Haskell using parser combinators.",
    language: "Haskell",
    url: "https://github.com/Sang-it/json-parser",
    tags: ["parsing", "json", "parser-combinators"],
  },
  {
    name: "sw",
    description: "CLI tool to switch audio sources from the command line on macOS.",
    language: "Python",
    url: "https://github.com/Sang-it/sw",
    tags: ["cli", "macos", "audio"],
  },
  {
    name: "cws",
    description: "CS 450 project for automated server setup and configuration management.",
    language: "TypeScript",
    url: "https://github.com/Sang-it/cws",
    tags: ["devops", "automation", "server-management"],
  },

  {
    name: "xv6-riscv-ext",
    description: "xv6-riscv osdev project extended with a C compiler and other utils.",
    language: "C",
    featured: true,
    url: " https://github.com/Sang-it/xv6-riscv-ext",
    tags: ["operating-system", "kernel"],
  },
];
