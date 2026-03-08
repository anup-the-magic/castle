# TODO: Demand all functions eg "demand bat" up front. Lua style config files? Or is that overkill?
(( $+commands[_warn] )) && function() {
  filename="/home/anupk/.oh-my-zsh/custom/2-aliases.zsh"
  echo "WARNING: _warn name collision in $filename" >&2
} && return

function _warn() {
  echo "WARNING: $@" >&2
}

(( $+commands[mise] )) && {
  eval "$(mise activate zsh)"
  # This should get handled by the mise plugin
  # eval "$(mise hook-env -s zsh)"
} || _warn "mise is not available, things might not be set up!"

(( $+commands[tig] )) && {
  alias tigs="tig status";
} || _warn "tig is not installed!"

(( $+commands[git-lfs] )) && {
  source <(git lfs completion zsh)
  compdef _git-lfs git-lfs
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

(( $+commands[batcat] )) && alias bat=batcat
(( $+commands[bat] )) && {
  alias bathelp="bat -plhelp"
} || _warn "bat is not installed!"

(( $+commands[fd] )) && {
  alias fd="fd --hidden"
} || _warn "fd is not installed!"

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
unfunction _warn
