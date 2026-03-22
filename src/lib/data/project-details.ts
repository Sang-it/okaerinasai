export interface ProjectDetail {
  slug: string;
  name: string;
  description: string;
  overview: string;
  language: string;
  languages: { name: string; bytes: number; percentage: number }[];
  url: string;
  stars: number;
  forks: number;
  loc: string;
  area: string;
  useCases: string[];
  features: string[];
  techStack: string[];
  createdAt: string;
  updatedAt: string;
}

function computePercentages(
  langs: { name: string; bytes: number }[],
): { name: string; bytes: number; percentage: number }[] {
  const total = langs.reduce((s, l) => s + l.bytes, 0);
  return langs.map((l) => ({
    ...l,
    percentage: Math.round((l.bytes / total) * 1000) / 10,
  }));
}

export const projectDetails: Record<string, ProjectDetail> = {
  memory: {
    slug: "memory",
    name: "memory",
    description:
      "Your memories, reimagined. A personal memory management application built in Rust.",
    overview:
      "Enfinyte is a high-performance memory persistence layer built in Rust for LLMs and AI agents. It provides semantic memory storage, retrieval, and search through MCP (Model Context Protocol) and gRPC interfaces — with AI-powered annotation that automatically classifies, tags, and scores memories.",
    language: "Rust",
    languages: computePercentages([
      { name: "Rust", bytes: 342477 },
      { name: "Python", bytes: 9108 },
      { name: "Dockerfile", bytes: 1368 },
      { name: "Shell", bytes: 919 },
    ]),
    url: "https://github.com/enfinyte/memory",
    stars: 1,
    forks: 0,
    loc: "~20.2k",
    area: "AI Infrastructure / Memory Systems",
    useCases: [
      "Persistent memory for AI coding agents and assistants",
      "Semantic search across conversation history",
      "Multi-tenant memory isolation for SaaS AI products",
      "Document ingestion and knowledge extraction from PDFs and websites",
      "Memory-augmented retrieval for RAG pipelines",
    ],
    features: [
      "Multi-tenant memory with OAuth authentication",
      "Semantic search via Qdrant or pgvector backends",
      "Dual interfaces — MCP for LLMs + gRPC for programmatic access",
      "AI-powered annotation with auto-classification and tagging",
      "Rich memory types — Semantic, Episodic, Procedural, Instruction, Relational, Working, Prospective",
      "Document ingestion from PDFs and websites",
    ],
    techStack: [
      "Rust",
      "Qdrant",
      "pgvector",
      "gRPC / Protobuf",
      "MCP (Model Context Protocol)",
      "Cloudflare Workers AI",
      "WorkOS OAuth",
      "Docker",
    ],
    createdAt: "2025-06-11",
    updatedAt: "2026-01-26",
  },

  router: {
    slug: "router",
    name: "router",
    description:
      "An LLM routing platform for intelligently distributing requests across language model providers.",
    overview:
      "An LLM routing platform that routes requests to the optimal LLM and provider, built on the OpenResponses API spec. A Bun monorepo using Effect-TS, it supports multiple AI providers (OpenAI, Anthropic, Amazon Bedrock) and includes a web dashboard with authentication.",
    language: "TypeScript",
    languages: computePercentages([
      { name: "TypeScript", bytes: 739031 },
      { name: "CSS", bytes: 7679 },
      { name: "Dockerfile", bytes: 2674 },
      { name: "Shell", bytes: 1202 },
      { name: "JavaScript", bytes: 467 },
      { name: "HCL", bytes: 212 },
    ]),
    url: "https://github.com/enfinyte/router",
    stars: 1,
    forks: 0,
    loc: "~54.8k",
    area: "AI Infrastructure / LLM Operations",
    useCases: [
      "Cost-optimized routing across multiple LLM providers",
      "Unified API gateway for AI applications",
      "Load balancing and failover across model providers",
      "Usage tracking and analytics for LLM spend",
      "Provider abstraction layer for multi-model applications",
    ],
    features: [
      "OpenResponses API spec compatibility",
      "Multi-provider support — OpenAI, Anthropic, Amazon Bedrock",
      "Web dashboard with authentication",
      "Request routing and optimization",
      "Monorepo architecture with shared packages",
      "Ledger system for usage tracking",
    ],
    techStack: [
      "Bun",
      "TypeScript",
      "Effect-TS",
      "Vercel AI SDK",
      "SolidJS",
      "Hono",
      "PostgreSQL",
      "Kysely",
      "better-auth",
      "HashiCorp Vault",
    ],
    createdAt: "2026-01-30",
    updatedAt: "2026-03-21",
  },

  "evenscribe-collector": {
    slug: "evenscribe-collector",
    name: "evenscribe-collector",
    description:
      "Log collector for the Evenscribe logging infrastructure. Ingests, processes, and forwards logs to ClickHouse.",
    overview:
      "A high-performance log collector for the Evenscribe logging infrastructure. It ingests, processes, and forwards logs to ClickHouse or PostgreSQL backends. Installable via Homebrew with client libraries available for Go, JavaScript/TypeScript, and Rust.",
    language: "C++",
    languages: computePercentages([
      { name: "C++", bytes: 2023788 },
      { name: "C", bytes: 304249 },
      { name: "CMake", bytes: 23779 },
      { name: "NASL", bytes: 9319 },
      { name: "Makefile", bytes: 2585 },
      { name: "Starlark", bytes: 947 },
    ]),
    url: "https://github.com/enfinyte/evenscribe-collector",
    stars: 1,
    forks: 0,
    loc: "~92.4k",
    area: "Observability / Logging Infrastructure",
    useCases: [
      "Centralized log collection for distributed systems",
      "Real-time log ingestion into ClickHouse for analytics",
      "Structured logging pipeline for microservices",
      "Application performance monitoring data collection",
      "Multi-language logging from Go, TypeScript, and Rust services",
    ],
    features: [
      "High-performance log ingestion and forwarding",
      "ClickHouse and PostgreSQL backend support",
      "Configurable via ~/.evenscriberc JSON file",
      "Homebrew installation support",
      "Client libraries for Go, JavaScript/TypeScript, and Rust",
    ],
    techStack: ["C++", "C", "CMake", "ClickHouse", "PostgreSQL", "Homebrew"],
    createdAt: "2024-05-02",
    updatedAt: "2024-08-01",
  },

  fluoride: {
    slug: "fluoride",
    name: "fluoride",
    description:
      "Neovim plugin that lets you view, reorder, and rename top-level code declarations through a floating window. Powered by Treesitter and LSP.",
    overview:
      "A structural code editor for Neovim. It provides a floating window to view, reorder, rename, duplicate, delete, and comment top-level code declarations. Supports TypeScript, JavaScript, Python, Lua, Go, Rust, C, and C++ through Treesitter grammars and LSP integration.",
    language: "Lua",
    languages: computePercentages([{ name: "Lua", bytes: 208369 }]),
    url: "https://github.com/Sang-it/fluoride",
    stars: 30,
    forks: 1,
    loc: "~12.3k",
    area: "Developer Tools / Code Navigation",
    useCases: [
      "Structural code navigation in Neovim",
      "Refactoring — reorder, rename, and reorganize declarations",
      "Quick overview of file structure without scrolling",
      "Batch operations on code declarations",
      "Language-agnostic code manipulation across 8+ languages",
    ],
    features: [
      "View, reorder, rename, duplicate, delete, and comment declarations",
      "Multi-language support — TypeScript, JavaScript, Python, Lua, Go, Rust, C, C++",
      "Jump to declarations and peek preview",
      "LSP hover integration and arity display",
      "Auto-reload and responsive floating window layout",
      "Installable via lazy.nvim",
    ],
    techStack: ["Lua", "Neovim API", "Treesitter", "LSP"],
    createdAt: "2026-03-15",
    updatedAt: "2026-03-20",
  },

  nes_emulator: {
    slug: "nes_emulator",
    name: "nes_emulator",
    description:
      "NES emulator written in Rust. Emulates the 6502 CPU, PPU, and cartridge mapper hardware.",
    overview:
      "A Nintendo Entertainment System emulator built in Rust on top of SDL2. It emulates the 6502 CPU, PPU (Picture Processing Unit), and cartridge mapper hardware. Based on the 'Writing NES Emulator' ebook by bugzmanov.",
    language: "Rust",
    languages: computePercentages([{ name: "Rust", bytes: 106300 }]),
    url: "https://github.com/Sang-it/nes_emulator",
    stars: 0,
    forks: 0,
    loc: "~4.9k",
    area: "Systems Programming / Emulation",
    useCases: [
      "Learning computer architecture through emulation",
      "Understanding the 6502 CPU instruction set",
      "Retro game preservation and playback",
      "Studying PPU rendering pipelines",
      "Low-level systems programming practice in Rust",
    ],
    features: [
      "6502 CPU emulation with full instruction set",
      "PPU (Picture Processing Unit) rendering",
      "Cartridge mapper hardware support",
      "SDL2-based display and input handling",
    ],
    techStack: ["Rust", "SDL2"],
    createdAt: "2024-02-05",
    updatedAt: "2024-02-07",
  },

  wave: {
    slug: "wave",
    name: "wave",
    description:
      "Multi-paradigm programming language implemented in Rust. Supports both functional and imperative styles.",
    overview:
      "An over-engineered multi-paradigm toy language with its own ecosystem, built in Rust. Features JavaScript-like syntax with functions, classes, inheritance, and variable declarations. The parser and tree-walking interpreter are fully completed, with planned ByteCode-Interpreter (VM) and LLVM backend. Inspired by the oxc-project.",
    language: "Rust",
    languages: computePercentages([{ name: "Rust", bytes: 271223 }]),
    url: "https://github.com/Sang-it/wave",
    stars: 0,
    forks: 0,
    loc: "~15.3k",
    area: "Programming Languages / Compiler Design",
    useCases: [
      "Learning language implementation from tokenizer to interpreter",
      "Experimenting with multi-paradigm language design",
      "Studying parser construction and AST design",
      "Building a foundation for compiler backends (VM, LLVM)",
      "Understanding scope resolution and class inheritance",
    ],
    features: [
      "Full parser with JavaScript-like syntax",
      "Tree-walking interpreter with binary/logical ops",
      "Environment scopes and variable resolution",
      "Classes, inheritance, and module system",
      "Planned: ByteCode VM, LLVM backend, Linter, Formatter, LSP",
    ],
    techStack: ["Rust"],
    createdAt: "2024-01-10",
    updatedAt: "2024-02-16",
  },

  neural_engine: {
    slug: "neural_engine",
    name: "neural_engine",
    description:
      "Neural network engine built from scratch using only NumPy. CS 499 Independent Study project.",
    overview:
      "A deep learning framework written in Python using only NumPy — no PyTorch, no TensorFlow. Built as a CS 499 Independent Study project, inspired by the tinygrad project by geohot. Implements neural network primitives from the ground up.",
    language: "Python",
    languages: computePercentages([{ name: "Python", bytes: 125608 }]),
    url: "https://github.com/Sang-it/neural_engine",
    stars: 0,
    forks: 0,
    loc: "~7.0k",
    area: "Machine Learning / Deep Learning Frameworks",
    useCases: [
      "Understanding neural network internals without framework abstractions",
      "Learning backpropagation and gradient computation from scratch",
      "Educational reference for deep learning fundamentals",
      "Experimenting with custom neural network architectures",
      "Benchmarking against production frameworks",
    ],
    features: [
      "Neural network primitives built from scratch",
      "NumPy-only implementation — no external ML libraries",
      "Forward and backward pass computation",
      "Inspired by tinygrad architecture",
    ],
    techStack: ["Python", "NumPy"],
    createdAt: "2024-11-27",
    updatedAt: "2024-11-27",
  },

  nand2tetris: {
    slug: "nand2tetris",
    name: "nand2tetris",
    description:
      "A complete computer built from NAND gates up through hardware, assembler (Scala), VM (C++), compiler (Elixir, C#/ANTLR), and OS.",
    overview:
      "A full implementation of 'The Elements of Computing Systems' — building a modern computer from NAND gates. All 12 projects completed: Boolean Logic, Boolean Arithmetic, Memory, Machine Language, Computer Architecture, Assembler (Scala), VM Translator (C++), High-Level Language, Compiler (Elixir + C#/ANTLR), and Operating System.",
    language: "Scala / C++ / Elixir / C#",
    languages: computePercentages([
      { name: "C++", bytes: 19855 },
      { name: "C#", bytes: 18794 },
      { name: "Scala", bytes: 10797 },
      { name: "Elixir", bytes: 9389 },
      { name: "ANTLR", bytes: 2442 },
      { name: "Hack", bytes: 1037 },
      { name: "Assembly", bytes: 590 },
      { name: "CMake", bytes: 183 },
    ]),
    url: "https://github.com/Sang-it/nand2tetris",
    stars: 0,
    forks: 0,
    loc: "~3.8k",
    area: "Computer Architecture / From Scratch",
    useCases: [
      "Deep understanding of computer architecture from gates to OS",
      "Learning how assemblers, VMs, and compilers work",
      "Educational reference for 'The Elements of Computing Systems'",
      "Polyglot programming practice across 4+ languages",
      "Understanding the full hardware-software stack",
    ],
    features: [
      "All 12 nand2tetris projects completed",
      "Assembler implemented in Scala",
      "VM Translator (Stage I & II) in C++",
      "Compiler Stage I in Elixir, Stage II in C#/ANTLR",
      "Full operating system implementation",
      "Hardware — Boolean logic, ALU, memory, CPU",
    ],
    techStack: ["Scala", "C++", "Elixir", "C#", "ANTLR", "HDL"],
    createdAt: "2024-02-10",
    updatedAt: "2024-05-20",
  },

  strings: {
    slug: "strings",
    name: "strings",
    description:
      "Parser generator written in Rust for building custom parsers from grammar definitions.",
    overview:
      "A parser generator written in Rust that enables building custom parsers from grammar definitions. It generates parsers from declarative grammar specs, useful for creating domain-specific languages and custom file format parsers.",
    language: "Rust",
    languages: computePercentages([{ name: "Rust", bytes: 13735 }]),
    url: "https://github.com/Sang-it/strings",
    stars: 0,
    forks: 0,
    loc: "~922",
    area: "Parsing / Code Generation",
    useCases: [
      "Generating parsers from grammar definitions",
      "Building domain-specific language parsers",
      "Custom file format parsing",
      "Learning parser generator internals",
      "Compiler frontend tooling",
    ],
    features: [
      "Grammar-driven parser generation",
      "Rust-based implementation for performance",
      "Declarative grammar specification",
    ],
    techStack: ["Rust"],
    createdAt: "2024-09-01",
    updatedAt: "2024-09-01",
  },

  "scheme._.": {
    slug: "scheme._.",
    name: "scheme._.",
    description:
      "Functional programming language interpreter written in Haskell, implementing a Scheme dialect.",
    overview:
      "A Scheme dialect implementation in Haskell. Supports variable declarations, function declarations, and function calls. Runs as an interactive REPL or can evaluate Scheme source files. Installable via cabal.",
    language: "Haskell",
    languages: computePercentages([
      { name: "Haskell", bytes: 20780 },
      { name: "Scheme", bytes: 2129 },
      { name: "Dockerfile", bytes: 141 },
    ]),
    url: "https://github.com/Sang-it/scheme._.",
    stars: 0,
    forks: 0,
    loc: "~1.3k",
    area: "Programming Languages / Functional Programming",
    useCases: [
      "Learning functional language implementation in Haskell",
      "Understanding Scheme semantics and evaluation",
      "Interactive REPL for Scheme experimentation",
      "Studying parser combinators and evaluation strategies",
      "Educational reference for interpreter construction",
    ],
    features: [
      "Variable and function declarations",
      "Function calls with proper scoping",
      "Interactive REPL mode",
      "File evaluation mode",
      "Installable via cabal",
    ],
    techStack: ["Haskell", "Cabal", "Docker"],
    createdAt: "2023-11-20",
    updatedAt: "2024-01-21",
  },

  t_rex: {
    slug: "t_rex",
    name: "t_rex",
    description:
      "NFA/DFA-based regex engine built in TypeScript. Implements Thompson's construction and subset construction algorithms.",
    overview:
      "An NFA/DFA-based regex engine built in TypeScript. Published as an npm package (@rux12/t_rex). Supports building regex patterns via string syntax or builder functions. Implements Thompson's construction for NFA building and subset construction for DFA conversion. Inspired by study of Formal Grammar, Chomsky Hierarchy, and Finite State Machines.",
    language: "TypeScript",
    languages: computePercentages([
      { name: "JavaScript", bytes: 113454 },
      { name: "TypeScript", bytes: 16206 },
    ]),
    url: "https://github.com/Sang-it/t_rex",
    stars: 0,
    forks: 0,
    loc: "~3.7k",
    area: "Formal Languages / Automata Theory",
    useCases: [
      "Learning NFA/DFA construction algorithms",
      "Understanding regex engine internals",
      "Pattern matching without external regex libraries",
      "Studying Thompson's construction and subset construction",
      "Educational reference for formal language theory",
    ],
    features: [
      "NFA construction via Thompson's algorithm",
      "DFA conversion via subset construction",
      "String syntax and builder function APIs",
      "Published as npm package (@rux12/t_rex)",
    ],
    techStack: ["TypeScript", "JavaScript", "npm"],
    createdAt: "2024-01-07",
    updatedAt: "2024-01-10",
  },

  brainfuck: {
    slug: "brainfuck",
    name: "brainfuck",
    description: "Brainfuck interpreter implemented in Haskell with parsing and evaluation.",
    overview:
      "A Brainfuck interpreter written in Haskell. A single-file implementation that parses and evaluates Brainfuck programs. Run via GHCi for interactive Brainfuck execution.",
    language: "Haskell",
    languages: computePercentages([{ name: "Haskell", bytes: 2163 }]),
    url: "https://github.com/Sang-it/brainfuck",
    stars: 0,
    forks: 0,
    loc: "~137",
    area: "Esoteric Languages / Interpreters",
    useCases: [
      "Understanding Turing-complete minimal languages",
      "Learning interpreter construction in Haskell",
      "Brainfuck program execution and debugging",
      "Studying minimal instruction set computing",
    ],
    features: [
      "Full Brainfuck instruction set support",
      "Single-file Haskell implementation",
      "Interactive execution via GHCi",
      "Parsing and evaluation pipeline",
    ],
    techStack: ["Haskell", "GHCi"],
    createdAt: "2024-05-22",
    updatedAt: "2024-05-22",
  },

  "json-parser": {
    slug: "json-parser",
    name: "json-parser",
    description: "JSON parser written in Haskell using parser combinators.",
    overview:
      "A JSON parser built in Haskell using parser combinators. Supports both file parsing and interactive JSON string input via REPL. Installable via cabal.",
    language: "Haskell",
    languages: computePercentages([{ name: "Haskell", bytes: 2491 }]),
    url: "https://github.com/Sang-it/json-parser",
    stars: 0,
    forks: 0,
    loc: "~234",
    area: "Parsing / Data Formats",
    useCases: [
      "Learning parser combinator techniques in Haskell",
      "Understanding JSON format parsing from scratch",
      "Educational reference for functional parsing",
      "Interactive JSON validation and parsing",
    ],
    features: [
      "Parser combinator-based implementation",
      "File parsing and interactive REPL modes",
      "Full JSON spec parsing",
      "Installable via cabal",
    ],
    techStack: ["Haskell", "Cabal"],
    createdAt: "2023-11-25",
    updatedAt: "2023-11-27",
  },

  sw: {
    slug: "sw",
    name: "sw",
    description: "CLI tool to switch audio sources from the command line on macOS.",
    overview:
      "A Python CLI tool for switching between audio input/output devices on macOS with automatic Bluetooth connection support. Features smart device name matching (partial, case-insensitive), auto Bluetooth connection, device listing, and current device display.",
    language: "Python",
    languages: computePercentages([{ name: "Python", bytes: 13211 }]),
    url: "https://github.com/Sang-it/sw",
    stars: 4,
    forks: 0,
    loc: "~632",
    area: "CLI Tools / macOS Utilities",
    useCases: [
      "Switching audio devices without opening System Preferences",
      "Automating audio source switching in scripts",
      "Quick Bluetooth headphone connection from terminal",
      "Listing available audio devices programmatically",
    ],
    features: [
      "Smart device name matching — partial, case-insensitive",
      "Automatic Bluetooth connection support",
      "List all audio input/output devices",
      "Show current active device",
      "Requires blueutil and SwitchAudioSource via Homebrew",
    ],
    techStack: ["Python", "blueutil", "SwitchAudioSource", "Homebrew"],
    createdAt: "2025-09-17",
    updatedAt: "2025-09-17",
  },

  cws: {
    slug: "cws",
    name: "cws",
    description: "CS 450 project for automated server setup and configuration management.",
    overview:
      "A CS 450 course project for automated server setup and configuration management. Built in TypeScript for streamlining server provisioning and deployment workflows.",
    language: "TypeScript",
    languages: computePercentages([{ name: "TypeScript", bytes: 13953 }]),
    url: "https://github.com/Sang-it/cws",
    stars: 0,
    forks: 0,
    loc: "~1.8k",
    area: "DevOps / Server Automation",
    useCases: [
      "Automated server provisioning and setup",
      "Configuration management for development environments",
      "Streamlining deployment workflows",
      "Server infrastructure as code",
    ],
    features: [
      "Automated server setup scripts",
      "Configuration management",
      "TypeScript-based tooling",
    ],
    techStack: ["TypeScript"],
    createdAt: "2025-04-09",
    updatedAt: "2025-04-13",
  },

  "xv6-riscv-ext": {
    slug: "xv6-riscv-ext",
    name: "xv6-riscv-ext",
    description: "xv6-riscv osdev project extended with a C compiler and other utils.",
    overview:
      "An extended version of xv6, a re-implementation of Dennis Ritchie's and Ken Thompson's Unix Version 6 for modern RISC-V multiprocessors using ANSI C. Extended with a C compiler and additional utilities. Build and run with 'make qemu' using the RISC-V newlib toolchain.",
    language: "C",
    languages: computePercentages([
      { name: "C", bytes: 297385 },
      { name: "Assembly", bytes: 6686 },
      { name: "Makefile", bytes: 5619 },
      { name: "Python", bytes: 5561 },
      { name: "Linker Script", bytes: 1533 },
      { name: "Perl", bytes: 808 },
      { name: "Emacs Lisp", bytes: 86 },
    ]),
    url: "https://github.com/Sang-it/xv6-riscv-ext",
    stars: 0,
    forks: 0,
    loc: "~22.4k",
    area: "Operating Systems / Kernel Development",
    useCases: [
      "Learning OS internals — process scheduling, virtual memory, file systems",
      "Understanding RISC-V architecture and system programming",
      "Extending a real Unix kernel with custom features",
      "Studying C compiler implementation within an OS context",
      "Educational reference for operating systems courses",
    ],
    features: [
      "Full xv6 Unix kernel for RISC-V multiprocessor",
      "Extended with a C compiler",
      "Additional system utilities",
      "Build and run via 'make qemu'",
      "RISC-V newlib toolchain support",
    ],
    techStack: ["C", "RISC-V Assembly", "QEMU", "Make", "Python"],
    createdAt: "2025-12-03",
    updatedAt: "2025-12-03",
  },
};
