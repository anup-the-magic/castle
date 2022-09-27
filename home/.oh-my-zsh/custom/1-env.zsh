if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

# ----- Setup autocompletion targets
[ -x "$(command -v kitty)" ] && source <(kitty + complete setup bash)
[ -f "$HOME/.company/.zshrc" ] && source "$HOME/.company/.zshrc"

# ----- Prompt
if [ -f "$HOME/.company/.zsh_prompt" ]; then source "$HOME/.company/.zsh_prompt"
elif [ -f "$HOME/.zsh_prompt" ]; then source "$HOME/.zsh_prompt";
fi

bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode

unsetopt correct_all

if $LOADED_PATH; then
  export LOADED_PATH=true
  TEMP_PATH=(
    /usr/local/bin
    $GNU_SED_PATH

    # --------------- DEFAULT_PATH
    $PATH
    # --------------- END DEFAULT_PATH

    $HOME/bin
    /usr/local/sbin
    $HOME/.nim/bin
    $HOME/Library/Haskell/bin
    $HOME/.nimble/bin
    $HOME/.local/bin
    ./._tmp
    .
  )
  export PATH=${(j/:/)TEMP_PATH}
fi

[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer

export LESS='FRX-S --mouse'

(( $+commands[nvim] ))    && {
  export EDITOR=nvim
  export GIT_EDITOR=$EDITOR
  alias vim=nvim
}
