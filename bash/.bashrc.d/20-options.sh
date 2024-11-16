#!/usr/bin/env bash

# check the window size after each command and, if necessary,
# Update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# Recursive globbing, e.g. `echo **/*.txt`
shopt -s globstar

# `**/qux` will enter `./foo/bar/baz/qux`
shopt -s autocd

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Autocorrect on directory names to match a glob.
shopt -s dirspell

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

