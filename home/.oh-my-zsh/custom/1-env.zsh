typeset -U path

path=(
  "/usr/local/bin"

  $path

  "$HOME/bin"
  "/usr/local/sbin"
  "$HOME/.nim/bin"
  "$HOME/Library/Haskell/bin"
  "$HOME/.nimble/bin"
  "$HOME/.local/bin"
)

if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
  path = ("$GNU_SED_PATH" $path)
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

[ -d /usr/share/doc/fzf ] && {
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
}


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


[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env

export LESS='FRX-S --mouse'

(( $+commands[nvim] )) && {
  export EDITOR=nvim
  export GIT_EDITOR=$EDITOR
  alias vim=nvim
}

(( $+commands[gem] )) && {
  export GEM_PATH=$HOME/gems
  path+=$GEM_PATH/bin
}

path+=./._tmp
path+=.

export PATH
