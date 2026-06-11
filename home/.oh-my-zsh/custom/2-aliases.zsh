(( $+commands[tig] ))     && {
  alias tigs="tig status";
}

(( $+commands[thefuck] )) && eval $(thefuck --alias)

(( $+commands[batcat] )) && {
  alias bat=batcat
  alias batman='bat -plman'
  alias bathelp="print -P %F{226}Merge stderr and capture with '2>&1 | bat -plhelp'%f'\n'"
  alias plhelp='bat -plhelp'
}

(( $+commands[nvim] )) && {
  export EDITOR=nvim
  export GIT_EDITOR=$EDITOR
  alias vim=nvim

  [[ -f "~/.config/nvim.old/init.vim" ]] && {
    alias nvim.old='NVIM_APPNAME="nvim.old" nvim'
  }
}

[ -x "$(command -v kitty)" ] && source <(kitty + complete setup bash)

if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
  path = ("$GNU_SED_PATH" $path)
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  elif (( $+commands[rg] )); then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  fi
  export FZF_DEFAULT_OPTS='--height=40% --reverse --inline-info'
fi

(( $+commands[gem] )) && {
  export GEM_PATH=$HOME/gems
  path+=$GEM_PATH/bin
}

tree.dir () {
  if (( $+commands[fd] )) ; then
    fd=fd
  else
    fd=git ls-files
  fi

  treecmd="tree $@ --fromfile"
  $fd | entr -dcrs "$fd | $treecmd"
}

alias swap-to-win='cd $(git get-remote-dir windows)'
alias swap-to-wsl='cd $(git get-remote-dir wsl)'
alias swap-dirs='cd $(git get-remote-dir $(git remote | grep -v origin))'

# fix help
unalias run-help >/dev/null 2>&1
autoload run-help
export HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help
