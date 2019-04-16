if [ -f "$HOME/.secrets" ]; then
  source "$HOME/.secrets"
fi

export NVM_DIR="$HOME/.nvm"
export MONO_GAC_PREFIX="/usr/local"
export EDITOR=vim
export PGDATA=/usr/local/var/postgres
export PATH="$PATH:/usr/local/sbin:$HOME/.nim/bin:$HOME/Library/Haskell/bin:$HOME/.nimble/bin:$HOME/.local/bin:./._tmp:."
# export PATH=$PATH:"$(stack path --compiler-tools-bin)"

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1 POWERLINE_BASH_SELECT=1 . /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

[ -f "$(brew --prefix)/etc/bash_completion" ] && source "$(brew --prefix)/etc/bash_completion"
[ -f "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"
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
