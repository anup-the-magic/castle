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
alias 'comm'='git commit -m'
alias 'g.files'='git show --pretty="" --name-only HEAD'
alias ports='lsof -i -P -n | grep "(LISTEN)" | awk '"'"'{print $1 " (PID: " $2 ") on " $9}'"'"''
alias projects='la ~/.projects'
alias go.alias='ln -s $(pwd) $GOROOT'

function ports-on {
  local port=$1
  lsof -i -P -n | grep "(LISTEN)" | grep "$port" | awk '{print $2}'
}

if [ -f ~/.postgres_aliases ]; then
  source ~/.postgres_aliases
fi
alias postgres.server="pg_ctl -D /usr/local/var/postgres/"

alias 'sourceme'='source ~/.bash_profile'
alias src='sourceme'
alias 'resource'='unalias -a && source ~/.bash_profile'
alias "finder.show_hidden"="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias "finder.hide_all"="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

function jsonl {
  [ $# -ge 1 ] && [ -f "$1" ] && input="$1" || input="-"
  cat $input | sed = | sed 'N;s/\n/": /;s/^/"/;s/$/,/;$s/,$/}/' | sed '1s/^/{/'
}
alias norg="gron --ungron"
alias ungron="gron --ungron"
alias decomment='sed -e "s/^-- //"'

function gitall {
  local branch=$1
  local workdirs=${@:2}
  for folder in $workdirs; do
    echo =========== $folder ===========
    cd $folder
    git ch $branch
    cd -
  done
}
function config-search {
  (cd ~/2s;
  ag "\b$1\b" --ignore dist --ignore resources/ -W 100 e3/ server/ datastore-lib/ visualizations/ scala/)
}

function rmpro {
  rm -i ~/.projects/$1;
  resource
}
function project {
  if [ "$#" -le 1 ]
  then
    echo "Usage: project from to" >&2
    return
  fi
  ln -s ~/2s/$1 ~/.projects/$2;
  sourceme;
}

function remind_me {
  local msg=$1

  local duration=${2:-10}

  sleep $duration && say $msg
  remind_me "$msg" $duration
}

function export-toml {
  usage="usage: $0 [-c|--config config] [-p|--prefix prefix] [-k|--key key]"

  config=config.toml
  prefix='\U'
  key=env

  while [ $# -gt 0 ]
  do
    case $1 in
      -c|--config) config=$2; shift ;;
      -p|--prefix) prefix=$2; shift ;;
      -k|--key   ) key=$2; shift ;;
      (*) echo "$usage" >&2
    esac
    shift
  done

  sed -e '0,/\['"$key"'\]/d;/\[,$p/d;s/.*=/export '"$prefix"'&/' "$config"
}

PROJECTS=~/.projects/*
shopt -s nullglob
for D in $PROJECTS
do
  alias "$(basename $D)"="cd -P $D"
done
shopt -u nullglob
alias downloads='cd ~/Downloads/'

alias 'pwrln.dir'='cd /usr/local/lib/python3.6/site-packages/powerline'

[[ -s "/Users/anupkishore/.gvm/scripts/gvm" ]] && source "/Users/anupkishore/.gvm/scripts/gvm"

homeshick --quiet refresh
