shopt -s globstar

if [ -f "$HOME/.bashrc" ]; then
  source "$HOME/.bashrc"
fi

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

alias 'sourceme'='source ~/.bash_profile'
alias src='sourceme'
alias 'resource'='unalias -a && source ~/.bash_profile'
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

alias 'pwrln.dir'='cd /usr/local/lib/python3.7/site-packages/powerline'

[ -e /Users/anup/.nix-profile/etc/profile.d/nix.sh ] && source /Users/anup/.nix-profile/etc/profile.d/nix.sh # added by Nix installer
