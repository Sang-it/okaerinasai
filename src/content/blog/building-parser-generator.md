---
title: Building a Parser Generator
date: '2024-09-20'
description: Creating strings - a parser generator for custom parsers from grammar definitions.
---

# Building a Parser Generator

After writing several parsers from scratch, I noticed I was repeating the same patterns: tokenization, grammar rules, error handling, parse tree construction. I built `strings`, a parser generator in Rust, to automate this.

The input is a grammar definition - production rules that define the syntax of a language. A rule has a left-hand side (a non-terminal) and a right-hand side (a sequence of terminals and non-terminals). For example, `expr ::= expr '+' term | term` defines expressions.

The parser generator implements LR parsing. It computes the LR(0) items, builds the canonical collection of LR(0) items, and then constructs the parsing action and goto tables. The action table tells the parser whether to shift, reduce, accept, or report an error for each state and lookahead token. The goto table tells the parser which state to transition to after reducing by a given rule.

An LR(0) item for a grammar rule represents that we've recognized part of a production and expect to see certain tokens next. The dot indicates how far we've progressed in parsing the rule.

Code generation converts the parsing tables into executable Rust code. The generated parser is a state machine that reads tokens, consults the action table, performs actions (shift or reduce), and transitions states using the goto table. When reducing, it builds a parse tree or calls semantic actions associated with the rule.

Error recovery allows the parser to continue after encountering a syntax error. Simple recovery skips tokens until a synchronizing token is found. More sophisticated recovery inserts tokens or uses heuristics to resync. The goal is to find multiple errors in one parse rather than stopping at the first one.

The grammar definition language is itself parsed by the parser generator, creating a bootstrap problem. I wrote an initial parser for the grammar language by hand, then used it to parse subsequent grammar definitions.

Using a parser generator saves time but adds a dependency. You define the grammar, run the generator, and integrate the output into your project. When the grammar changes, regenerate the parser. This workflow works well for stable grammars and when you want to focus on semantics rather than parsing mechanics.
