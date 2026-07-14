open! Core

type t =
  { slug : string
  ; overview : string
  ; languages : (string * int) list
  ; loc : string
  ; area : string
  ; use_cases : string list
  ; features : string list
  ; tech_stack : string list
  }

let percentages langs =
  let total = List.sum (module Int) langs ~f:snd |> Int.to_float in
  List.map langs ~f:(fun (name, bytes) ->
    let pct =
      if Float.equal total 0.
      then 0.
      else Float.round_nearest (Int.to_float bytes /. total *. 1000.) /. 10.
    in
    name, pct)
;;

let pct_str p =
  let s = Printf.sprintf "%.1f" p in
  if String.is_suffix s ~suffix:".0" then String.drop_suffix s 2 else s
;;

let all =
  [ { slug = "memory"
    ; overview =
        "Enfinyte is a high-performance memory persistence layer built in Rust for LLMs \
         and AI agents. It provides semantic memory storage, retrieval, and search \
         through MCP (Model Context Protocol) and gRPC interfaces — with AI-powered \
         annotation that automatically classifies, tags, and scores memories."
    ; languages = [ "Rust", 342477; "Python", 9108; "Dockerfile", 1368; "Shell", 919 ]
    ; loc = "~20.2k"
    ; area = "AI Infrastructure / Memory Systems"
    ; use_cases =
        [ "Persistent memory for AI coding agents and assistants"
        ; "Semantic search across conversation history"
        ; "Multi-tenant memory isolation for SaaS AI products"
        ; "Document ingestion and knowledge extraction from PDFs and websites"
        ; "Memory-augmented retrieval for RAG pipelines"
        ]
    ; features =
        [ "Multi-tenant memory with OAuth authentication"
        ; "Semantic search via Qdrant or pgvector backends"
        ; "Dual interfaces — MCP for LLMs + gRPC for programmatic access"
        ; "AI-powered annotation with auto-classification and tagging"
        ; "Rich memory types — Semantic, Episodic, Procedural, Instruction, Relational, \
           Working, Prospective"
        ; "Document ingestion from PDFs and websites"
        ]
    ; tech_stack =
        [ "Rust"
        ; "Qdrant"
        ; "pgvector"
        ; "gRPC / Protobuf"
        ; "MCP (Model Context Protocol)"
        ; "Cloudflare Workers AI"
        ; "WorkOS OAuth"
        ; "Docker"
        ]
    }
  ; { slug = "router"
    ; overview =
        "An LLM routing platform that routes requests to the optimal LLM and provider, \
         built on the OpenResponses API spec. A Bun monorepo using Effect-TS, it \
         supports multiple AI providers (OpenAI, Anthropic, Amazon Bedrock) and includes \
         a web dashboard with authentication."
    ; languages =
        [ "TypeScript", 739031
        ; "CSS", 7679
        ; "Dockerfile", 2674
        ; "Shell", 1202
        ; "JavaScript", 467
        ; "HCL", 212
        ]
    ; loc = "~54.8k"
    ; area = "AI Infrastructure / LLM Operations"
    ; use_cases =
        [ "Cost-optimized routing across multiple LLM providers"
        ; "Unified API gateway for AI applications"
        ; "Load balancing and failover across model providers"
        ; "Usage tracking and analytics for LLM spend"
        ; "Provider abstraction layer for multi-model applications"
        ]
    ; features =
        [ "OpenResponses API spec compatibility"
        ; "Multi-provider support — OpenAI, Anthropic, Amazon Bedrock"
        ; "Web dashboard with authentication"
        ; "Request routing and optimization"
        ; "Monorepo architecture with shared packages"
        ; "Ledger system for usage tracking"
        ]
    ; tech_stack =
        [ "Bun"
        ; "TypeScript"
        ; "Effect-TS"
        ; "Vercel AI SDK"
        ; "SolidJS"
        ; "Hono"
        ; "PostgreSQL"
        ; "Kysely"
        ; "better-auth"
        ; "HashiCorp Vault"
        ]
    }
  ; { slug = "evenscribe-collector"
    ; overview =
        "A high-performance log collector for the Evenscribe logging infrastructure. It \
         ingests, processes, and forwards logs to ClickHouse or PostgreSQL backends. \
         Installable via Homebrew with client libraries available for Go, \
         JavaScript/TypeScript, and Rust."
    ; languages =
        [ "C++", 2023788
        ; "C", 304249
        ; "CMake", 23779
        ; "NASL", 9319
        ; "Makefile", 2585
        ; "Starlark", 947
        ]
    ; loc = "~92.4k"
    ; area = "Observability / Logging Infrastructure"
    ; use_cases =
        [ "Centralized log collection for distributed systems"
        ; "Real-time log ingestion into ClickHouse for analytics"
        ; "Structured logging pipeline for microservices"
        ; "Application performance monitoring data collection"
        ; "Multi-language logging from Go, TypeScript, and Rust services"
        ]
    ; features =
        [ "High-performance log ingestion and forwarding"
        ; "ClickHouse and PostgreSQL backend support"
        ; "Configurable via ~/.evenscriberc JSON file"
        ; "Homebrew installation support"
        ; "Client libraries for Go, JavaScript/TypeScript, and Rust"
        ]
    ; tech_stack = [ "C++"; "C"; "CMake"; "ClickHouse"; "PostgreSQL"; "Homebrew" ]
    }
  ; { slug = "fluoride"
    ; overview =
        "A structural code editor for Neovim. It provides a floating window to view, \
         reorder, rename, duplicate, delete, and comment top-level code declarations. \
         Supports TypeScript, JavaScript, Python, Lua, Go, Rust, C, and C++ through \
         Treesitter grammars and LSP integration."
    ; languages = [ "Lua", 208369 ]
    ; loc = "~12.3k"
    ; area = "Developer Tools / Code Navigation"
    ; use_cases =
        [ "Structural code navigation in Neovim"
        ; "Refactoring — reorder, rename, and reorganize declarations"
        ; "Quick overview of file structure without scrolling"
        ; "Batch operations on code declarations"
        ; "Language-agnostic code manipulation across 8+ languages"
        ]
    ; features =
        [ "View, reorder, rename, duplicate, delete, and comment declarations"
        ; "Multi-language support — TypeScript, JavaScript, Python, Lua, Go, Rust, C, C++"
        ; "Jump to declarations and peek preview"
        ; "LSP hover integration and arity display"
        ; "Auto-reload and responsive floating window layout"
        ; "Installable via lazy.nvim"
        ]
    ; tech_stack = [ "Lua"; "Neovim API"; "Treesitter"; "LSP" ]
    }
  ; { slug = "nes_emulator"
    ; overview =
        "A Nintendo Entertainment System emulator built in Rust on top of SDL2. It \
         emulates the 6502 CPU, PPU (Picture Processing Unit), and cartridge mapper \
         hardware. Based on the 'Writing NES Emulator' ebook by bugzmanov."
    ; languages = [ "Rust", 106300 ]
    ; loc = "~4.9k"
    ; area = "Systems Programming / Emulation"
    ; use_cases =
        [ "Learning computer architecture through emulation"
        ; "Understanding the 6502 CPU instruction set"
        ; "Retro game preservation and playback"
        ; "Studying PPU rendering pipelines"
        ; "Low-level systems programming practice in Rust"
        ]
    ; features =
        [ "6502 CPU emulation with full instruction set"
        ; "PPU (Picture Processing Unit) rendering"
        ; "Cartridge mapper hardware support"
        ; "SDL2-based display and input handling"
        ]
    ; tech_stack = [ "Rust"; "SDL2" ]
    }
  ; { slug = "wave"
    ; overview =
        "An over-engineered multi-paradigm toy language with its own ecosystem, built in \
         Rust. Features JavaScript-like syntax with functions, classes, inheritance, and \
         variable declarations. The parser and tree-walking interpreter are fully \
         completed, with planned ByteCode-Interpreter (VM) and LLVM backend. Inspired by \
         the oxc-project."
    ; languages = [ "Rust", 271223 ]
    ; loc = "~15.3k"
    ; area = "Programming Languages / Compiler Design"
    ; use_cases =
        [ "Learning language implementation from tokenizer to interpreter"
        ; "Experimenting with multi-paradigm language design"
        ; "Studying parser construction and AST design"
        ; "Building a foundation for compiler backends (VM, LLVM)"
        ; "Understanding scope resolution and class inheritance"
        ]
    ; features =
        [ "Full parser with JavaScript-like syntax"
        ; "Tree-walking interpreter with binary/logical ops"
        ; "Environment scopes and variable resolution"
        ; "Classes, inheritance, and module system"
        ; "Planned: ByteCode VM, LLVM backend, Linter, Formatter, LSP"
        ]
    ; tech_stack = [ "Rust" ]
    }
  ; { slug = "neural_engine"
    ; overview =
        "A deep learning framework written in Python using only NumPy — no PyTorch, no \
         TensorFlow. Built as a CS 499 Independent Study project, inspired by the \
         tinygrad project by geohot. Implements neural network primitives from the \
         ground up."
    ; languages = [ "Python", 125608 ]
    ; loc = "~7.0k"
    ; area = "Machine Learning / Deep Learning Frameworks"
    ; use_cases =
        [ "Understanding neural network internals without framework abstractions"
        ; "Learning backpropagation and gradient computation from scratch"
        ; "Educational reference for deep learning fundamentals"
        ; "Experimenting with custom neural network architectures"
        ; "Benchmarking against production frameworks"
        ]
    ; features =
        [ "Neural network primitives built from scratch"
        ; "NumPy-only implementation — no external ML libraries"
        ; "Forward and backward pass computation"
        ; "Inspired by tinygrad architecture"
        ]
    ; tech_stack = [ "Python"; "NumPy" ]
    }
  ; { slug = "nand2tetris"
    ; overview =
        "A full implementation of 'The Elements of Computing Systems' — building a \
         modern computer from NAND gates. All 12 projects completed: Boolean Logic, \
         Boolean Arithmetic, Memory, Machine Language, Computer Architecture, Assembler \
         (Scala), VM Translator (C++), High-Level Language, Compiler (Elixir + \
         C#/ANTLR), and Operating System."
    ; languages =
        [ "C++", 19855
        ; "C#", 18794
        ; "Scala", 10797
        ; "Elixir", 9389
        ; "ANTLR", 2442
        ; "Hack", 1037
        ; "Assembly", 590
        ; "CMake", 183
        ]
    ; loc = "~3.8k"
    ; area = "Computer Architecture / From Scratch"
    ; use_cases =
        [ "Deep understanding of computer architecture from gates to OS"
        ; "Learning how assemblers, VMs, and compilers work"
        ; "Educational reference for 'The Elements of Computing Systems'"
        ; "Polyglot programming practice across 4+ languages"
        ; "Understanding the full hardware-software stack"
        ]
    ; features =
        [ "All 12 nand2tetris projects completed"
        ; "Assembler implemented in Scala"
        ; "VM Translator (Stage I & II) in C++"
        ; "Compiler Stage I in Elixir, Stage II in C#/ANTLR"
        ; "Full operating system implementation"
        ; "Hardware — Boolean logic, ALU, memory, CPU"
        ]
    ; tech_stack = [ "Scala"; "C++"; "Elixir"; "C#"; "ANTLR"; "HDL" ]
    }
  ; { slug = "strings"
    ; overview =
        "A parser generator written in Rust that enables building custom parsers from \
         grammar definitions. It generates parsers from declarative grammar specs, \
         useful for creating domain-specific languages and custom file format parsers."
    ; languages = [ "Rust", 13735 ]
    ; loc = "~922"
    ; area = "Parsing / Code Generation"
    ; use_cases =
        [ "Generating parsers from grammar definitions"
        ; "Building domain-specific language parsers"
        ; "Custom file format parsing"
        ; "Learning parser generator internals"
        ; "Compiler frontend tooling"
        ]
    ; features =
        [ "Grammar-driven parser generation"
        ; "Rust-based implementation for performance"
        ; "Declarative grammar specification"
        ]
    ; tech_stack = [ "Rust" ]
    }
  ; { slug = "scheme._."
    ; overview =
        "A Scheme dialect implementation in Haskell. Supports variable declarations, \
         function declarations, and function calls. Runs as an interactive REPL or can \
         evaluate Scheme source files. Installable via cabal."
    ; languages = [ "Haskell", 20780; "Scheme", 2129; "Dockerfile", 141 ]
    ; loc = "~1.3k"
    ; area = "Programming Languages / Functional Programming"
    ; use_cases =
        [ "Learning functional language implementation in Haskell"
        ; "Understanding Scheme semantics and evaluation"
        ; "Interactive REPL for Scheme experimentation"
        ; "Studying parser combinators and evaluation strategies"
        ; "Educational reference for interpreter construction"
        ]
    ; features =
        [ "Variable and function declarations"
        ; "Function calls with proper scoping"
        ; "Interactive REPL mode"
        ; "File evaluation mode"
        ; "Installable via cabal"
        ]
    ; tech_stack = [ "Haskell"; "Cabal"; "Docker" ]
    }
  ; { slug = "t_rex"
    ; overview =
        "An NFA/DFA-based regex engine built in TypeScript. Published as an npm package \
         (@rux12/t_rex). Supports building regex patterns via string syntax or builder \
         functions. Implements Thompson's construction for NFA building and subset \
         construction for DFA conversion. Inspired by study of Formal Grammar, Chomsky \
         Hierarchy, and Finite State Machines."
    ; languages = [ "JavaScript", 113454; "TypeScript", 16206 ]
    ; loc = "~3.7k"
    ; area = "Formal Languages / Automata Theory"
    ; use_cases =
        [ "Learning NFA/DFA construction algorithms"
        ; "Understanding regex engine internals"
        ; "Pattern matching without external regex libraries"
        ; "Studying Thompson's construction and subset construction"
        ; "Educational reference for formal language theory"
        ]
    ; features =
        [ "NFA construction via Thompson's algorithm"
        ; "DFA conversion via subset construction"
        ; "String syntax and builder function APIs"
        ; "Published as npm package (@rux12/t_rex)"
        ]
    ; tech_stack = [ "TypeScript"; "JavaScript"; "npm" ]
    }
  ; { slug = "brainfuck"
    ; overview =
        "A Brainfuck interpreter written in Haskell. A single-file implementation that \
         parses and evaluates Brainfuck programs. Run via GHCi for interactive Brainfuck \
         execution."
    ; languages = [ "Haskell", 2163 ]
    ; loc = "~137"
    ; area = "Esoteric Languages / Interpreters"
    ; use_cases =
        [ "Understanding Turing-complete minimal languages"
        ; "Learning interpreter construction in Haskell"
        ; "Brainfuck program execution and debugging"
        ; "Studying minimal instruction set computing"
        ]
    ; features =
        [ "Full Brainfuck instruction set support"
        ; "Single-file Haskell implementation"
        ; "Interactive execution via GHCi"
        ; "Parsing and evaluation pipeline"
        ]
    ; tech_stack = [ "Haskell"; "GHCi" ]
    }
  ; { slug = "json-parser"
    ; overview =
        "A JSON parser built in Haskell using parser combinators. Supports both file \
         parsing and interactive JSON string input via REPL. Installable via cabal."
    ; languages = [ "Haskell", 2491 ]
    ; loc = "~234"
    ; area = "Parsing / Data Formats"
    ; use_cases =
        [ "Learning parser combinator techniques in Haskell"
        ; "Understanding JSON format parsing from scratch"
        ; "Educational reference for functional parsing"
        ; "Interactive JSON validation and parsing"
        ]
    ; features =
        [ "Parser combinator-based implementation"
        ; "File parsing and interactive REPL modes"
        ; "Full JSON spec parsing"
        ; "Installable via cabal"
        ]
    ; tech_stack = [ "Haskell"; "Cabal" ]
    }
  ; { slug = "sw"
    ; overview =
        "A Python CLI tool for switching between audio input/output devices on macOS \
         with automatic Bluetooth connection support. Features smart device name \
         matching (partial, case-insensitive), auto Bluetooth connection, device \
         listing, and current device display."
    ; languages = [ "Python", 13211 ]
    ; loc = "~632"
    ; area = "CLI Tools / macOS Utilities"
    ; use_cases =
        [ "Switching audio devices without opening System Preferences"
        ; "Automating audio source switching in scripts"
        ; "Quick Bluetooth headphone connection from terminal"
        ; "Listing available audio devices programmatically"
        ]
    ; features =
        [ "Smart device name matching — partial, case-insensitive"
        ; "Automatic Bluetooth connection support"
        ; "List all audio input/output devices"
        ; "Show current active device"
        ; "Requires blueutil and SwitchAudioSource via Homebrew"
        ]
    ; tech_stack = [ "Python"; "blueutil"; "SwitchAudioSource"; "Homebrew" ]
    }
  ; { slug = "cws"
    ; overview =
        "A CS 450 course project for automated server setup and configuration \
         management. Built in TypeScript for streamlining server provisioning and \
         deployment workflows."
    ; languages = [ "TypeScript", 13953 ]
    ; loc = "~1.8k"
    ; area = "DevOps / Server Automation"
    ; use_cases =
        [ "Automated server provisioning and setup"
        ; "Configuration management for development environments"
        ; "Streamlining deployment workflows"
        ; "Server infrastructure as code"
        ]
    ; features =
        [ "Automated server setup scripts"
        ; "Configuration management"
        ; "TypeScript-based tooling"
        ]
    ; tech_stack = [ "TypeScript" ]
    }
  ; { slug = "xv6-riscv-ext"
    ; overview =
        "An extended version of xv6, a re-implementation of Dennis Ritchie's and Ken \
         Thompson's Unix Version 6 for modern RISC-V multiprocessors using ANSI C. \
         Extended with a C compiler and additional utilities. Build and run with 'make \
         qemu' using the RISC-V newlib toolchain."
    ; languages =
        [ "C", 297385
        ; "Assembly", 6686
        ; "Makefile", 5619
        ; "Python", 5561
        ; "Linker Script", 1533
        ; "Perl", 808
        ; "Emacs Lisp", 86
        ]
    ; loc = "~22.4k"
    ; area = "Operating Systems / Kernel Development"
    ; use_cases =
        [ "Learning OS internals — process scheduling, virtual memory, file systems"
        ; "Understanding RISC-V architecture and system programming"
        ; "Extending a real Unix kernel with custom features"
        ; "Studying C compiler implementation within an OS context"
        ; "Educational reference for operating systems courses"
        ]
    ; features =
        [ "Full xv6 Unix kernel for RISC-V multiprocessor"
        ; "Extended with a C compiler"
        ; "Additional system utilities"
        ; "Build and run via 'make qemu'"
        ; "RISC-V newlib toolchain support"
        ]
    ; tech_stack = [ "C"; "RISC-V Assembly"; "QEMU"; "Make"; "Python" ]
    }
  ]
;;

let find slug = List.find all ~f:(fun p -> String.equal p.slug slug)
let has slug = Option.is_some (find slug)
