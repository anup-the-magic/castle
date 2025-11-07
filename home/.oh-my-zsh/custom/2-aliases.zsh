(( $+commands[tig] ))     && {
  alias tigs="tig status";
  function tig-grep() {
    git branch -a | grep $1 | xargs -o tig --all
  }
}

(( $+commands[thefuck] )) && eval $(thefuck --alias)

(( $+commands[nvim] )) && {
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
