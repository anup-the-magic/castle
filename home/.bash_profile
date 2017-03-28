set -o vi
shopt -s globstar

if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi

alias 'ls'='ls -G'
alias 'll'='ls -l'
alias 'la'='ls -al'
alias tmux='tmux -2'

alias 'tigs'='tig status'
alias 'comm'='git commit -m'
alias 'g.files'='git show --pretty="" --name-only HEAD'
alias ports='lsof -i -P -n | grep "(LISTEN)" | awk '"'"'{print $1 " (PID:" $2 ") on " $9}'"'"''
alias projects='la ~/.projects'

if [ -f ~/.postgres_aliases ]; then
  source ~/.postgres_aliases
fi
alias postgres.server="pg_ctl -D /usr/local/var/postgres/"

alias 'sourceme'='source ~/.bash_profile'
alias src='sourceme'
alias 'resource'='unalias -a && source ~/.bash_profile'

function jsonl {
  [ $# -ge 1 -a -f "$1" ] && input="$1" || input="-"
  cat $input | sed = | sed 'N;s/\n/": /;s/^/"/;s/$/,/;$s/,$/}/' | sed '1s/^/{/'
}
alias json='python -m json.tool'

function getdata {
  if [ "$#" -le 1 ]
  then
    shopt -s nullglob
    for folder in ~/2s/test-data/*; do
      for file in $folder/*; do
        echo "$(basename $folder) - $(basename $file)"
      done
    done
    shopt -u nullglob
    return 1
  fi
  local folder=$1/src/$3/resources/$2
  local target=test-data/$1/$2.$3.$4
  read -p "update $folder with $target? [yN] " -n 1 -r
  local folder=~/2s/$folder
  local target=~/2s/$target
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Nn]?$ || ! -e $target ]]
  then
    echo "available options for project $1:"
    shopt -s nullglob
    for file in ~/2s/test-data/$1/*; do
      echo $file
    done
    shopt -u nullglob
    return 1
  fi
  rm -rf $folder
  cp -r $target $folder
}

function putdata {
  local folder=$1/src/$3/resources/$2
  local target=test-data/$1/$2.$3.$4
  read -p "update $target with $folder? [yN] " -n 1 -r
  local folder=~/2s/$folder
  local target=~/2s/$target
  echo
  if [[ $REPLY =~ ^[Nn]?$ || ! -e $folder ]]
  then
    if [[ ! -e $folder ]]
    then
      echo "$folder does not exist!"
    fi
    return 1
  fi
  cp -r $folder $target
  echo "done"
}

alias alldirs='"e3/ datastore-lib/ scala/ server/ visualizations/"'

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
