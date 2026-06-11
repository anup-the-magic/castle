typeset -U path

path=(
  # local overrides
  "._tmp/bin"
  # testing dir
  "$HOME/scratch/sh"
  "$HOME/company/bin"

  $path
  "/usr/local/bin"
  "$HOME/.dotnet/tools"
  "$HOME/bin"
  "/usr/local/sbin"
  "$HOME/.nim/bin"
  "$HOME/Library/Haskell/bin"
  "$HOME/.nimble/bin"
  "$HOME/.local/bin"
)

if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
  path=(
    "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
    "$(brew --prefix)/bin" # prefer brew-installed objects to not, possibly breaks things
    $path
  )

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

[ -d /usr/share/doc/fzf ] && {
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
}


# ----- Prompt
if [ -f "$HOME/.company/.zsh_prompt" ]; then source "$HOME/.company/.zsh_prompt"
elif [ -f "$HOME/.zsh_prompt" ]; then source "$HOME/.zsh_prompt";
fi

bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'cc' vi-change-whole-line
bindkey -M vicmd 'C-r' history-inc-search

# I think I just prefer always having block mode...
_blinking_block() { echo -ne '\e[1 q' }
precmd_functions+=( _blinking_block   )

unsetopt correct_all
unsetopt BEEP

# ----- Command setup
[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer
[ -f "$HOME/.ghcup/env"      ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f "$HOME/.cargo/env"      ] && source "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/mise" ] && {
  eval "$(/home/anup/.local/bin/mise activate zsh)"
  path+="$HOME/.local/share/mise/shims"
}

# for "Don't clear screen", use "LESS=X$LESS", for "don't chop lines", use LESS="$LESS -+S"
export LESS='FRS --mouse'


# we like scratch work, and we like being able to execute the current directory (which can be scary)
path+=./._tmp
path+=.

export PATH

# Always cd -P, use -L to override
setopt CHASE_LINKS
