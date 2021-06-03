export ZSH="/Users/anup/.oh-my-zsh"

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode

ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
# ZSH_CUSTOM=/path/to/new-custom-folder

# oh-my-zsh tmux plugin
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOQUIT="true"

# ASDF requires fpath modifications prior to plugins
# Homeshick requires fpath modifications prior to plugins, but after sourcing
[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ] && source "$HOME/.homesick/repos/homeshick/homeshick.sh"

fpath=(
  $HOME/.homesick/repos/homeshick/completions
  $HOME/.asdf/completions
  $fpath
)

plugins=(
  asdf
  cabal
  docker
  fasd
  fzf
  gitfast
  osx
  tmux
  web-search
)

[ -f "$HOME/.completions.zsh" ] && source "$HOME/.completions.zsh"
source $ZSH/oh-my-zsh.sh
# source ~/.purepower
