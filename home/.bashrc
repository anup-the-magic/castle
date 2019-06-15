shopt -s globstar
alias 'ls'='ls -G'
alias 'll'='ls -l'
alias 'la'='ls -al'
alias curl='curl -w "\n"'
alias tmux='tmux -2'

alias 'tigs'='tig status'
alias 'g.files'='git show --pretty="" --name-only HEAD'
alias ports='lsof -i -P -n | grep "(LISTEN)" | awk '"'"'{print $1 " (PID: " $2 ") on " $9}'"'"''
alias projects='la ~/.projects'
alias go.alias='ln -s $(pwd) $GOROOT'

function ports-on() {
  local port=$1
  lsof -i -P -n | grep "(LISTEN)" | grep "$port" | awk '{print $2}'
}

[ -f ~/.postgres_aliases ] && source ~/.postgres_aliases
alias postgres.server="pg_ctl -D /usr/local/var/postgres/"

alias "finder.show_hidden"="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias "finder.hide_all"="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"
alias norg="gron --ungron"
alias ungron="gron --ungron"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias runtime="ps -o etime= -p"

function remind_me() {
  local msg=$1

  local duration=${2:-10}

  sleep $duration && say $msg
  remind_me "$msg" $duration
}

if [ -f "$HOME/.secrets" ]; then
  source "$HOME/.secrets"
fi

export NVM_DIR="$HOME/.nvm"
export MONO_GAC_PREFIX="/usr/local"
export EDITOR=vim
export PGDATA=/usr/local/var/postgres
export PATH="$PATH:/usr/local/sbin:$HOME/.nim/bin:$HOME/Library/Haskell/bin:$HOME/.nimble/bin:$HOME/.local/bin:./._tmp:."
# export PATH=$PATH:"$(stack path --compiler-tools-bin)"

if [ -x "$(command -v powerline-daemon)" ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1 POWERLINE_BASH_SELECT=1 . /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
fi

if [ -x "$(command -v brew)" ]; then
  [ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
fi
[ -f ~/git-flow-completion ] && source ~/git-flow-completion/git-flow-completion.bash
[ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -x "$(command -v stack)" ] && eval "$(stack --bash-completion-script stack)"
[ -x "$(command -v thefuck)" ] && eval "$(thefuck --alias)"

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
fi

if [ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
  source "$HOME/.homesick/repos/homeshick/homeshick.sh"
  source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
  homeshick --quiet refresh
fi

[ -x "$(command -v kitty)" ] && source <(kitty + complete setup bash)
[ -f "$HOME/.company/.bashrc" ] && source "$HOME/.company/.bashrc"

if [ -f "$HOME/.company/.bashrc" ]; then source "$HOME/.company/.bash_prompt"
elif [ -f "$HOME/.bash_prompt" ]; then source "$HOME/.bash_prompt";
fi
