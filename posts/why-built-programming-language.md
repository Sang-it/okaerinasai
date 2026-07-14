---
title: Why I Built My Own Programming Language
date: '2024-01-25'
description: Creating Wave language in Rust and the challenges of language design.
---

# Why I Built My Own Programming Language

I built `Wave` to understand what goes into a programming language. It's a multi-paradigm language implemented in Rust, supporting both functional and imperative styles.

The lexing and parsing stages went quickly. Rust's pattern matching made writing the parser straightforward - define tokens, write a grammar, match tokens to rules. The parser produces an AST that represents the structure of the program.

The type system was the real challenge. I wanted static typing with type inference, finding a balance between explicit annotations and the compiler figuring things out. Too much inference and error messages become cryptic. Too much explicit typing and the language feels verbose. I ended up with a Hindley-Milner style system where types are inferred but can be annotated when desired.

Evaluation strategy took iteration. I implemented eager evaluation first, which is simpler but requires dealing with strictness and order of operations. Lazy evaluation changes how you think about programs - expressions aren't evaluated until their values are needed. I eventually went with a mix: strict by default, lazy where it matters.

Pattern matching in function definitions makes code declarative. You can write `factorial 0 = 1; factorial n = n * factorial (n - 1)` instead of if-else chains. This felt powerful for list processing and recursive algorithms.

Language design involves trade-offs at every step. Should the language have exceptions or return error types? Should variables be mutable by default or immutable? Every decision ripples through the rest of the implementation. Building Wave gave me perspective on why existing languages make the choices they do.
