(( $+commands[tig] ))     && {
  alias tigs="tig status";
  function tig-grep() {
    git branch -a | grep $1 | xargs -o tig --all
  }
}
(( $+commands[thefuck] )) && eval $(thefuck --alias)
(( $+commands[nvim] ))    && alias vim=nvim
