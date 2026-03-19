---
title: Automated Server Setup with TypeScript
date: '2025-04-25'
description: CS 450 project on configuration management and automated server setup.
---

# Automated Server Setup with TypeScript

For CS 450, I built a configuration management tool in TypeScript that automates server setup. The goal: describe the desired server state in a configuration file, and the tool makes it happen.

The configuration is declarative - you specify what you want, not how to get there. A typical config might include packages to install, files to create, services to configure, and users to set up. The tool compares the desired state to the actual state and makes only the necessary changes.

Idempotency is essential. Running the configuration multiple times should produce the same result and should be safe to run repeatedly. If a package is already installed, the tool skips it. If a file already has the correct content, it doesn't overwrite it. This makes the tool safe to run automatically on a schedule or after manual changes.

I organized the tool around resource types. Each resource type (package, file, service, user) has methods for checking current state, applying desired state, and reverting changes. This interface is consistent across all resources, making the code modular and testable.

Dependency management determines the order of operations. Some resources depend on others - you can't start a service before installing it, you can't write to a directory before creating it. The tool builds a dependency graph from these relationships and uses topological sorting to find a valid execution order. Cycles in dependencies are errors.

Error handling and rollback are important for reliability. If a resource fails to apply, the tool should report the error and optionally roll back changes to resources that already succeeded. Full transactional semantics are hard to implement (you can't always undo package installs), but partial rollback is better than leaving the system in an inconsistent state.

The tool connects to servers over SSH, executes commands, and reports results. Running remotely adds complexity - file transfers, command execution, error propagation. But it allows managing multiple servers from one configuration.

This project showed me that infrastructure automation applies software engineering principles: modularity, testability, clear interfaces. Good tooling makes infrastructure changes predictable and repeatable.
