if [ -f "$HOME/.secrets" ]; then
  source "$HOME/.secrets"
fi

if [ -f "$HOME/.asdf/asdf.sh" ]; then
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
fi

export PATH="$PATH:/usr/local/sbin:$HOME/.nim/bin:$HOME/.nimble/bin:$HOME/.local/bin:./._tmp:."

export PGDATA=/usr/local/var/postgres

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1 POWERLINE_BASH_SELECT=1 . /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

[ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"

[ -f ~/git-flow-completion ] && source ~/git-flow-completion/git-flow-completion.bash

[ -f ~/.git-completion.bash ] && source ~/.git-completion.bash

if [ -x "$(command -v stack)" ]; then
  eval "$(stack --bash-completion-script stack)"
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

eval "$(thefuck --alias)"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
export MONO_GAC_PREFIX="/usr/local"
export PATH=$HOME/2s/.bin:$PATH

export EDITOR=vim

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
