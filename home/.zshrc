# ~/.oh-my-zsh/custom/1-env.zsh
# ~/.oh-my-zsh/custom/2-aliases.zsh
# ~/.oh-my-zsh/custom/3-functions.zsh
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"

# requires vi-mode plugin
# VI_MODE_SET_CURSOR=true

# use manual installation of powerlevel10k
[[ -f "$ZSH_CUSTOM/themes/powerlevel10k/powerlevel10k.zsh-theme" ]] && ZSH_THEME="powerlevel10k/powerlevel10k"

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

# ASDF requires fpath modifications prior to plugins
# Homeshick requires fpath modifications prior to plugins, but after sourcing
[ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ] && source "$HOME/.homesick/repos/homeshick/homeshick.sh"

fpath=(
  "$HOME/.homesick/repos/homeshick/completions"
  "$HOME/.asdf/completions"
  $fpath
)

# skip all plugin aliases
zstyle ':omz:plugins:*' aliases no

# ~/.oh-my-zsh/plugins
ZSH_TMUX_AUTOQUIT=false
# ~/.oh-my-zsh/plugins
plugins=(
  # TODO: Warn on missing mise installation? Autoinstall mise?
  mise
  cabal
  docker
  fasd
  fzf
  gitfast

  tmux
  node
  aliases
  dotnet
  rust
  #... check again...
)
zstyle :omz:plugins:ssh-agent lazy yes
# Suppresses the "starting ssh-agent" message
zstyle :omz:plugins:ssh-agent quiet yes

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# NOTE: we want to disable ssh-agent in this
[[ -f "$HOME/company/shrc.sh" ]] && source "$HOME/company/shrc.sh"
[ -f "$HOME/company/zshrc.zsh" ] && source "$HOME/company/zshrc.zsh"
[ -f "$HOME/.completions.zsh" ] && source "$HOME/.completions.zsh"

source $ZSH/oh-my-zsh.sh
