#!/usr/bin/env bash

# set +h                              # Disable command hashing
set +o histexpand                   # disable !history expansion
set -o noclobber                    # Prevent file overwrite on stdout redirection
                                    # Use `>|` to force redirection to an existing file
# set -o physical                     # resolve symlinks when 'cd'ing
set -o vi

# shopt -s autocd                     # assume 'cd' when trying to exec a directory
shopt -s cdspell                    # spell check the path when changing directories.
shopt -s checkhash                  # re-check $PATH on hash failure
shopt -s checkjobs                  # print job status on exit
shopt -s checkwinsize               # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s cmdhist                    # store multi-line commands as single history entry
shopt -s dirspell                   # autocorrect on directory names to match a glob.
shopt -s dotglob                    # include dotfiles in globbing.
shopt -s extglob                    # extended globbing .@(…) +(…) etc. globs
shopt -s globstar                   # the ** glob, recursive globbing, e.g. `echo **/*.txt`
shopt -s histappend                 # append to $HISTFILE on exit. don't overwrite it.
shopt -s histreedit                 # allow re-editing failed history subst
shopt -s hostcomplete               # complete hostnames when using the ssh command.
shopt -s huponexit                  # send SIGHUP to jobs when the shell exits.
shopt -s no_empty_cmd_completion    # don't complete empty commands.
shopt -s nocaseglob                 # case-insensitive globbing (used in pathname expansion)
shopt -s nocasematch                # case insensitive matching.
# shopt -s nullglob                   # if no matches are found, the pattern expands to nothing. disabled for better completion experience.
shopt -s progcomp                   # programmable completion.
shopt -s promptvars                 # allow prompt strings to contain shell variables.
# shopt -s sourcepath                 # search the PATH for the directory containing a sourced script before using the current directory.

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# 022 is the "historical" value in Debian for UMASK
# 027, or even 077, could be considered better for privacy
umask 027

