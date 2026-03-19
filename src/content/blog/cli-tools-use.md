---
title: CLI Tools I Actually Use
date: '2025-10-01'
description: Building an audio source switcher for macOS and the philosophy of simple tools.
---

# CLI Tools I Actually Use

I built `sw`, a command-line tool for switching audio sources on macOS. The problem is common: switching between headphones, speakers, or AirPods requires opening System Preferences, navigating to Sound, and selecting the output device. Doing this multiple times a day is tedious.

`sw` lists available audio output devices and switches to the selected one with a single command: `sw "AirPods"`. Run without arguments, it prints the list of devices. Run with a device name, it switches to that device and prints confirmation.

I implemented this in Python using the `pyobjc` library, which provides Python bindings to macOS frameworks. CoreAudio is the framework that manages audio devices. The tool queries CoreAudio for the list of output devices, finds the device with a matching name, and sets it as the default output.

The tool is intentionally minimal. It doesn't run in the background, doesn't have configuration files, doesn't persist state between invocations. Each run is independent - list devices or switch to one device and exit. This simplicity makes it reliable and predictable.

Startup time matters for a CLI tool. If a tool takes a second to start, you notice it every time you use it. I kept imports minimal and only load what's necessary. The script is small enough that startup is nearly instant.

Error handling is straightforward. If CoreAudio returns an error, print the error message. If the device name doesn't match anything in the list, print "Device not found" and show the available devices. There's no retry logic or complex error recovery - the operation either succeeds or fails, and the user knows immediately.

This approach - do one thing, do it well, and get out of the way - applies to the tools I use daily. `ls` lists files. `grep` searches for patterns. `git` manages source control. Each has a focused purpose and a straightforward interface. `sw` follows this pattern: switch audio sources quickly from the command line.
