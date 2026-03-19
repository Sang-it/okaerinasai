---
title: From Regex Engines to Automata Theory
date: '2024-01-15'
description: Building t_rex regex engine in TypeScript using Thompson's construction.
---

# From Regex Engines to Automata Theory

Regular expressions are powerful, but I'd never thought about how they're actually implemented. I built `t_rex` to find out, implementing it as an NFA/DFA-based engine in TypeScript.

The approach: parse the regex into a syntax tree, convert it to a nondeterministic finite automaton (NFA) using Thompson's construction, then convert the NFA to a deterministic finite automaton (DFA) via subset construction. The DFA is what actually runs the match.

Thompson's construction is elegant. Each piece of the regex - literal character, concatenation, alternation, repetition - becomes a small NFA fragment. You glue them together with epsilon transitions. An alternation `a|b` becomes two parallel paths with epsilon branches. Kleene star `a*` adds a loop back with epsilon transitions.

Subset construction transforms the NFA into a DFA by considering sets of NFA states as single DFA states. The resulting DFA has more states but runs faster - no backtracking, just a single pass through the input.

The implementation challenged my understanding of automata theory. Getting character classes working meant understanding how ranges like `[a-z]` map to NFA transitions. Escaping special characters required careful handling during parsing. The recursion in the grammar meant building the AST correctly before generating the NFA.

Matching with a DFA is straightforward: start in the initial state, read each character, transition to the next state, check if you're in an accepting state. O(n) time, O(1) additional space. The real work happens during compilation, not matching.

This project gave me concrete experience with automata theory that went beyond textbooks. I still use regex engines in daily work, but now I understand what they're doing under the hood.
