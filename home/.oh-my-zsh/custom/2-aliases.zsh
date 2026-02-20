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

(( $+commands[nvim] )) && [[ -f "~/.config/nvim.old/init.vim" ]] && {
  alias nvim.old='NVIM_APPNAME="nvim.old" nvim'
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
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
alias help=run-help
