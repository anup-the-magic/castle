if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ----- Setup autocompletion targets
[ -x "$(command -v kitty)" ] && source <(kitty + complete setup bash)

# ----- Prompt
if [ -f "$HOME/.company/.zsh_prompt" ]; then source "$HOME/.company/.zsh_prompt"
elif [ -f "$HOME/.zsh_prompt" ]; then source "$HOME/.zsh_prompt";
fi

bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode

path=(
  /usr/local/bin
  $GNU_SED_PATH

  $path

  $HOME/bin
  /usr/local/sbin
  $HOME/.nim/bin
  $HOME/Library/Haskell/bin
  $HOME/.nimble/bin
  $HOME/.local/bin
  ./._tmp
  .
)
export PATH

export LESS=FRX

(( $+commands[nvim] ))    && {
  export EDITOR=nvim
  export GIT_EDITOR=$EDITOR
  alias vim=nvim
}

# ghcup-env
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"
# nix
[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh"

