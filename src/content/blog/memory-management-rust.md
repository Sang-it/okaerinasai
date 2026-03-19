---
title: Memory Management in Rust
date: '2025-07-01'
description: Building the Memory app and understanding Rust's ownership model.
---

# Memory Management in Rust

I built `Memory`, a personal note-taking and thought organization application, in Rust. The project gave me practical experience with Rust's ownership system and memory management model.

Rust's ownership rules: every value has an owner, there can only be one owner at a time, and when the owner goes out of scope, the value is dropped. This prevents use-after-free bugs and double frees. The borrow checker enforces these rules at compile time - you can't borrow a value mutably while it's borrowed immutably, and you can't have multiple mutable references to the same value.

Memory stores notes as data structures with fields for content, tags, creation date, and metadata. When you edit a note, you create a new version rather than mutating the original. This persistent data structure approach means you never lose data - you can always step back to previous versions. Rust's ownership model makes this work: you take ownership of the old note, create a modified copy, and return the new one.

Querying notes requires efficient lookups by various criteria: tags, text content, date ranges. I started with vectors and linear search, which is simple but slow for large datasets. I switched to B-trees for O(log n) lookups. Implementing B-trees in Rust requires careful ownership - nodes own their children, and inserting or deleting means creating new nodes and updating references.

Concurrency allows multiple operations to run simultaneously - you might search while another operation adds notes. Rust's `Send` and `Sync` traits define which types are safe to send between threads and share across threads. The B-trees I use are thread-safe for concurrent reads, but writes need locks. I used `RwLock` for read-write locking - multiple readers can access data simultaneously, but writers get exclusive access.

Error handling in Rust uses `Result<T, E>` for operations that can fail. Instead of exceptions or null checks, you explicitly handle success and failure cases. This forces you to think about error paths rather than ignoring them.

The borrow checker is challenging initially. You fight the compiler as you learn to structure code in ways ownership supports. But once it clicks, the code feels more robust. If it compiles, memory issues are unlikely. This confidence is valuable in a personal knowledge store where data integrity matters.
