---
title: My Journey into Functional Programming
date: '2024-06-05'
description: Building a Brainfuck interpreter in Haskell and how it changed my thinking.
---

# My Journey into Functional Programming

I implemented a Brainfuck interpreter in Haskell to get practical experience with functional programming. Brainfuck has eight commands (`> < + - . , [ ]`) that manipulate a tape of memory cells - minimal but complete enough to be Turing complete.

The interpreter state consists of the memory tape (a list or array), a head pointer (index into the tape), the instruction pointer (position in the Brainfuck program), and input/output buffers. In Haskell, I represented this as a record type with these fields.

Brainfuck programs are sequences of commands. Parsing the program is straightforward - read characters, ignore non-command characters, produce a list of commands. I represented commands as a sum type: `MoveRight`, `MoveLeft`, `Increment`, `Decrement`, `Output`, `Input`, and `Loop [Command]`.

The interpreter is a function that takes the initial state and produces a final state. Each command updates the state: `MoveRight` increments the head pointer, `Increment` adds one to the current cell, `Output` writes the current cell to the output buffer. The `Loop` command repeats a sequence of commands while the current cell is non-zero.

Implementing the loop requires jumping forward to the matching `]` when the current cell is zero, and jumping back to the matching `[` when the cell is non-zero at the `]`. I precomputed a map from each `[` position to its matching `]` position and vice versa. This makes execution a simple lookup instead of searching for brackets each time.

Haskell's type system guides the implementation. The state type captures all the mutable parts explicitly. The monadic structure of the interpreter (using `State` or `IO` depending on how you handle IO) makes the sequencing of operations clear. Pattern matching on commands makes the interpreter read almost like a specification.

Functional programming's emphasis on immutability and pure functions made the interpreter easier to reason about. Each step produces a new state rather than mutating the old one. This isn't always the most efficient approach, but it's simple and correct.

This project gave me concrete experience with functional patterns that I now apply in other languages. When I write Python or JavaScript, I think about data transformations instead of mutations, and I use higher-order functions more naturally.
