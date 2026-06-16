#!/bin/zsh
#
# .zshrc - Run on interactive Zsh session.
#

# Initialize profiling.
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Set critical options
setopt extended_glob

# Define critical functions
##? Cache the results of an eval command
function cached-eval {
  emulate -L zsh; setopt local_options extended_glob
  (( $# >= 2 )) || return 1

  local cmdname=$1; shift
  local memofile=$__zsh_cache_dir/memoized/${cmdname}.zsh
  local -a cached=($memofile(Nmh-20))
  if ! (( ${#cached} )); then
    mkdir -p ${memofile:h}
    "$@" >| $memofile
  fi
  source $memofile
}

# Load .zstyles file.
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Load .zshrc.pre file.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.pre ]] && source ${ZDOTDIR:-$HOME}/.zshrc.pre

# Init aliases.
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases

# Run local settings.
[[ -r ${ZDOTDIR:-$HOME}/.zshrc.local ]] && source ${ZDOTDIR:-$HOME}/.zshrc.local

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Build remaining path.
path=(
  $HOME/{,s}bin(N)
  $HOME/.local/{,s}bin(N)
  /opt/homebrew/{,s}bin(N)
  /usr/local/{,s}bin(N)
  /usr/{,s}bin(N)
  /{,s}bin(N)
)

# Load all configs
for _zrc in $ZDOTDIR/config/*.zsh
do
  source $_zrc
  unset _zrc
done

# Init prompt.
if ! (( $#prompt_themes > 0 )); then
  promptinit

  # Set prompt
  if [[ $TERM == dumb ]]; then
    prompt 'off'
  else
    # Set prompt.
    local -a prompt_argv
    zstyle -a ':zsh:feature:prompt' 'theme' 'prompt_argv'
    if (( $#prompt_argv == 0 )); then
      if (( $+commands[starship] )); then
        prompt_argv=(starship zephyr)
      else
        prompt_argv=(off)
      fi
    fi
    prompt "$prompt_argv[@]"
  fi
fi

mycompinit
source $__zsh_config_dir/completions/_az
compdef _gnu_generic fzf
compdef _man batman

# Finish profiling by calling zprof.
[[ "$ZPROFRC" -eq 1 ]] && zprof
[[ -v ZPROFRC ]] && unset ZPROFRC
