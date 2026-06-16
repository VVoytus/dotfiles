#
# env: Ensure common environment variables are set.
#

 # Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export VISUAL='vim'
else
  export VISUAL='nvim'
fi

export EDITOR="$VISUAL"

if (( $+commands[most] )); then
  export PAGER=${PAGER:-most}
else
  export PAGER=${PAGER:-less}
fi

export LANG=${LANG:-en_US.UTF-8}

# Setup GPG
export GPG_TTY=$(tty)

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
export LESS="${LESS:--g -i -M -R -S -w -z-4}"

# macOS
if [[ "$OSTYPE" == darwin* ]]; then
  # Make Apple Terminal behave.
  export SHELL_SESSIONS_DISABLE=1
  export BROWSER=${BROWSER:-open}
fi

# Enable less wait time between key presses
export KEYTIMEOUT=1

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
