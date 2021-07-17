# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

bindkey -v
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'cc' vi-change-whole-line

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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
