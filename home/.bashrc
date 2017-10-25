if [ -f .secrets ]; then
  source .secrets
fi

if [ -f /usr/local/opt/asdf/asdf.sh ]; then
  source /usr/local/opt/asdf/asdf.sh
fi

export NVM_DIR="$HOME/.nvm"
. "$(brew --prefix nvm)/nvm.sh"

export PATH="$PATH:/usr/local/sbin:$HOME/.nim/bin:$HOME/.nimble/bin:$HOME/.local/bin:."

export PGDATA=/usr/local/var/postgres

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f ~/git-flow-completion ]; then
  source ~/git-flow-completion/git-flow-completion.bash
fi

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

if [ -x "$(command -v stack)" ]; then
  eval "$(stack --bash-completion-script stack)"
fi

eval "$(thefuck --alias)"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
MONO_GAC_PREFIX="/usr/local"
export PATH=$HOME/2s/.bin:$PATH
