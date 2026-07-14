open! Core

module Hero = struct
  type t =
    { greeting : string
    ; first_name : string
    ; last_name : string
    ; title : string
    ; summary : string
    }

  let value =
    { greeting = "Hi, I'm"
    ; first_name = "Sangit"
    ; last_name = "Manandhar"
    ; title = "Software Engineer"
    ; summary =
        "I work with compilers, emulators, developer tools, and distributed systems."
    }
  ;;

  let sub = "I use neovim and dvorak btw."
end

let about =
  [ "I'm a software engineer interested in how things work at the lowest levels. I spend \
     my time working on programming languages, emulators, and systems infrastructure — \
     the kind of software that other software is built on."
  ; "My work spans from implementing CPU emulators and parser generators in Rust, to \
     designing functional languages in Haskell, to building production observability \
     infrastructure with ClickHouse."
  ; "I believe that the proper way to understand a system is to build it from scratch."
  ]
;;

module Contacts = struct
  type t =
    { github : string
    ; email : string
    ; linkedin : string
    ; cta : string
    }

  let value =
    { github = "https://github.com/Sang-it"
    ; email = "mailto:sangitmanandhar@outlook.com"
    ; linkedin = "https://www.linkedin.com/in/sangitmanandhar/"
    ; cta = "Interested in working together or just want to chat? Reach out."
    }
  ;;
end

module Project = struct
  type t =
    { name : string
    ; description : string
    ; language : string
    ; url : string
    ; featured : bool
    ; tags : string list
    ; created_at : string
    }

  let make
        ?(featured = false)
        ?(tags = [])
        ~name
        ~description
        ~language
        ~url
        ~created_at
        ()
    =
    { name; description; language; url; featured; tags; created_at }
  ;;
end

let projects =
  Project.
    [ make
        ~name:"memory"
        ~description:
          "Your memories, reimagined. A personal memory management application built in \
           Rust."
        ~language:"Rust"
        ~url:"https://github.com/enfinyte/memory"
        ~featured:true
        ~tags:[ "rust"; "application" ]
        ~created_at:"2025-06-11"
        ()
    ; make
        ~name:"router"
        ~description:
          "An LLM routing platform for intelligently distributing requests across \
           language model providers."
        ~language:"TypeScript"
        ~url:"https://github.com/enfinyte/router"
        ~featured:true
        ~tags:[ "llm"; "routing"; "ai-infrastructure" ]
        ~created_at:"2026-01-30"
        ()
    ; make
        ~name:"evenscribe-collector"
        ~description:
          "Log collector for the Evenscribe logging infrastructure. Ingests, processes, \
           and forwards logs to ClickHouse."
        ~language:"C++"
        ~url:"https://github.com/enfinyte/evenscribe-collector"
        ~featured:true
        ~tags:[ "observability"; "logging"; "clickhouse" ]
        ~created_at:"2024-05-02"
        ()
    ; make
        ~name:"fluoride"
        ~description:
          "Neovim plugin that lets you view, reorder, and rename top-level code \
           declarations through a floating window. Powered by Treesitter and LSP."
        ~language:"Lua"
        ~url:"https://github.com/Sang-it/fluoride"
        ~featured:true
        ~tags:[ "neovim"; "treesitter"; "lsp"; "developer-tools" ]
        ~created_at:"2026-03-15"
        ()
    ; make
        ~name:"nes_emulator"
        ~description:
          "NES emulator written in Rust. Emulates the 6502 CPU, PPU, and cartridge \
           mapper hardware."
        ~language:"Rust"
        ~url:"https://github.com/Sang-it/nes_emulator"
        ~featured:true
        ~tags:[ "emulation"; "systems-programming"; "6502" ]
        ~created_at:"2024-02-05"
        ()
    ; make
        ~name:"wave"
        ~description:
          "Multi-paradigm programming language implemented in Rust. Supports both \
           functional and imperative styles."
        ~language:"Rust"
        ~url:"https://github.com/Sang-it/wave"
        ~featured:true
        ~tags:[ "language-design"; "interpreter"; "compiler" ]
        ~created_at:"2024-01-10"
        ()
    ; make
        ~name:"neural_engine"
        ~description:
          "Neural network engine built from scratch using only NumPy. CS 499 Independent \
           Study project."
        ~language:"Python"
        ~url:"https://github.com/Sang-it/neural_engine"
        ~featured:true
        ~tags:[ "machine-learning"; "neural-networks"; "numpy" ]
        ~created_at:"2024-11-27"
        ()
    ; make
        ~name:"nand2tetris"
        ~description:
          "A complete computer built from NAND gates up through hardware, assembler \
           (Scala), VM (C++), compiler (Elixir, C#/ANTLR), and OS."
        ~language:"Scala / C++ / Elixir / C#"
        ~url:"https://github.com/Sang-it/nand2tetris"
        ~featured:true
        ~tags:[ "computer-architecture"; "hardware"; "from-scratch" ]
        ~created_at:"2024-02-10"
        ()
    ; make
        ~name:"strings"
        ~description:
          "Parser generator written in Rust for building custom parsers from grammar \
           definitions."
        ~language:"Rust"
        ~url:"https://github.com/Sang-it/strings"
        ~tags:[ "parsing"; "code-generation"; "compilers" ]
        ~created_at:"2024-09-01"
        ()
    ; make
        ~name:"scheme._."
        ~description:
          "Functional programming language interpreter written in Haskell, implementing \
           a Scheme dialect."
        ~language:"Haskell"
        ~url:"https://github.com/Sang-it/scheme._."
        ~featured:true
        ~tags:[ "functional-programming"; "interpreter"; "scheme" ]
        ~created_at:"2023-11-20"
        ()
    ; make
        ~name:"t_rex"
        ~description:
          "NFA/DFA-based regex engine built in TypeScript. Implements Thompson's \
           construction and subset construction algorithms."
        ~language:"TypeScript"
        ~url:"https://github.com/Sang-it/t_rex"
        ~tags:[ "automata"; "regex"; "formal-languages" ]
        ~created_at:"2024-01-07"
        ()
    ; make
        ~name:"brainfuck"
        ~description:
          "Brainfuck interpreter implemented in Haskell with parsing and evaluation."
        ~language:"Haskell"
        ~url:"https://github.com/Sang-it/brainfuck"
        ~tags:[ "esoteric-languages"; "interpreter" ]
        ~created_at:"2024-05-22"
        ()
    ; make
        ~name:"json-parser"
        ~description:"JSON parser written in Haskell using parser combinators."
        ~language:"Haskell"
        ~url:"https://github.com/Sang-it/json-parser"
        ~tags:[ "parsing"; "json"; "parser-combinators" ]
        ~created_at:"2023-11-25"
        ()
    ; make
        ~name:"sw"
        ~description:"CLI tool to switch audio sources from the command line on macOS."
        ~language:"Python"
        ~url:"https://github.com/Sang-it/sw"
        ~tags:[ "cli"; "macos"; "audio" ]
        ~created_at:"2025-09-17"
        ()
    ; make
        ~name:"cws"
        ~description:
          "CS 450 project for automated server setup and configuration management."
        ~language:"TypeScript"
        ~url:"https://github.com/Sang-it/cws"
        ~tags:[ "devops"; "automation"; "server-management" ]
        ~created_at:"2025-04-09"
        ()
    ; make
        ~name:"xv6-riscv-ext"
        ~description:"xv6-riscv osdev project extended with a C compiler and other utils."
        ~language:"C"
        ~url:"https://github.com/Sang-it/xv6-riscv-ext"
        ~featured:true
        ~tags:[ "operating-system"; "kernel" ]
        ~created_at:"2025-12-03"
        ()
    ]
;;

let find_project ~name =
  List.find projects ~f:(fun (p : Project.t) -> String.equal p.name name)
;;

module Skill_category = struct
  type t =
    { name : string
    ; items : string list
    }
end

let skills =
  Skill_category.
    [ { name = "Languages"
      ; items =
          [ "Rust"
          ; "TypeScript"
          ; "C"
          ; "C++"
          ; "C#"
          ; "Go"
          ; "Python"
          ; "Haskell"
          ; "Lua"
          ; "Scala"
          ; "Elixir"
          ; "Zig"
          ]
      }
    ; { name = "Infrastructure"
      ; items =
          [ "Docker"
          ; "gRPC / Protobuf"
          ; "PostgreSQL"
          ; "ClickHouse"
          ; "Qdrant"
          ; "pgvector"
          ; "Cloudflare Workers"
          ]
      }
    ; { name = "Web"
      ; items =
          [ "SvelteKit"
          ; "SolidJS"
          ; "React"
          ; "Next.js"
          ; "Astro"
          ; "Node.js"
          ; "Bun"
          ; "Hono"
          ; "Effect-TS"
          ]
      }
    ; { name = "Tools"
      ; items =
          [ "Neovim"
          ; "Git"
          ; "Linux"
          ; "CMake"
          ; "Treesitter"
          ; "LSP"
          ; "ANTLR"
          ; "SDL2"
          ; "QEMU"
          ]
      }
    ; { name = "AI / ML"
      ; items = [ "NumPy"; "MCP"; "Vercel AI SDK"; "RAG Pipelines"; "Vector Search" ]
      }
    ; { name = "Interests"
      ; items =
          [ "Language Design"
          ; "Compilers"
          ; "Emulation"
          ; "Systems Programming"
          ; "OS Development"
          ; "Observability"
          ; "AI Infrastructure"
          ; "Formal Languages"
          ; "Developer Tools"
          ]
      }
    ]
;;

module Experience = struct
  type t =
    { role : string
    ; description : string
    ; company : string
    ; timeline : string
    }
end

let experiences =
  Experience.
    [ { role = "Founding Engineer"
      ; description = ""
      ; company = "Tscircuit"
      ; timeline = "04/2026 - present"
      }
    ; { role = "Undergraduate Researcher"
      ; description =
          "Post-Graduate Research Fellow at CogAI Lab, building secure, scalable, \
           containerized infrastructure for AI and software engineering research."
      ; company = "Caldwell University"
      ; timeline = "03/2023 - 12/2025"
      }
    ]
;;

module Contribution = struct
  type pr =
    { title : string
    ; number : int
    ; url : string
    ; state : string
    ; merged_at : string
    ; description : string
    }

  type t =
    { slug : string
    ; project : string
    ; project_description : string
    ; project_url : string
    ; project_stars : int
    ; language : string
    ; pr : pr
    ; overview : string
    ; area : string
    ; tech_stack : string list
    }
end

let contributions =
  Contribution.
    [ { slug = "rmpc"
      ; project = "rmpc"
      ; project_description =
          "A modern, configurable, terminal-based MPD client with album art support via \
           various terminal image protocols."
      ; project_url = "https://github.com/mierak/rmpc"
      ; project_stars = 2550
      ; language = "Rust"
      ; pr =
          { title = "feat: add block album_art support"
          ; number = 377
          ; url = "https://github.com/mierak/rmpc/pull/377"
          ; state = "MERGED"
          ; merged_at = "2025-05-30"
          ; description =
              "Added block-character based album art rendering, bringing image display \
               to terminals without native image protocol support like Alacritty."
          }
      ; overview =
          "Implemented block album art rendering for rmpc by adapting techniques from \
           the viu project. This enables album art display in terminals that lack native \
           image protocol support (sixel, kitty, iTerm2) by using Unicode block \
           characters to approximate images. Tested and working on Alacritty."
      ; area = "Terminal Graphics / TUI"
      ; tech_stack = [ "Rust"; "ratatui"; "MPD"; "Unicode Block Characters" ]
      }
    ]
;;
