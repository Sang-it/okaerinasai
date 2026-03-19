---
title: Creating a Neovim Plugin with Treesitter
date: '2026-03-18'
description: Building Fluoride - code navigation plugin powered by Treesitter and LSP.
---

# Creating a Neovim Plugin with Treesitter

`Fluoride` is a Neovim plugin I built for viewing and reorganizing top-level code declarations. It uses Treesitter for parsing and displays a floating window with all functions, classes, and other top-level symbols.

Treesitter parses source code into a concrete syntax tree (CST) - not just the structure like an AST, but including comments and whitespace details. This allows the plugin to identify function definitions, classes, imports, and other declarations accurately across languages. Unlike regex-based approaches, Treesitter understands nesting and language-specific syntax.

The floating window shows a list of declarations with their types and line numbers. You can filter this list by typing to search, and pressing Enter jumps to the selected declaration. The window stays open while you navigate, so you can quickly jump between parts of a file without losing context.

Reordering uses Treesitter's understanding of code structure. When you drag a declaration to a new position in the list, the plugin identifies the corresponding node in the syntax tree, removes it, and inserts it at the new location. Treesitter handles the details - finding the exact character range, including nested nodes, and preserving whitespace. This is safer than manual text manipulation because the plugin understands the structure.

LSP (Language Server Protocol) integration provides additional information when available. LSP servers can provide symbol kind (function, method, class, etc.) and documentation for each declaration. Fluoride queries the LSP for this data when it's available, enriching the display with more context.

Neovim's Lua API is used for the plugin implementation. Lua is well-suited for this - it's fast, has good pattern matching through libraries, and integrates tightly with Neovim. The plugin uses the Treesitter parser API to query the syntax tree, the LSP client API to request symbol information, and the window API to create and manage the floating window.

Key mappings trigger the plugin's main functions: opening the declaration window, moving between items, and initiating reordering. The plugin is configured through Neovim's `vim.g` and `vim.opt` mechanisms, allowing users to customize key bindings, window size, and display options.

The plugin addresses a specific problem: navigating and reorganizing large files. Having a structured view of declarations and the ability to reorder them through drag-and-drop makes code organization easier. It's a tool I use daily when working on large codebases.
