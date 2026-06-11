typeset -U path

path=(
  # local overrides
  "._tmp/bin"
  # testing dir
  "$HOME/scratch/sh"
  "$HOME/company/bin"

  $path
  "/usr/local/bin"
  "$HOME/.dotnet/tools"
  "$HOME/bin"
  "/usr/local/sbin"
  "$HOME/.nim/bin"
  "$HOME/Library/Haskell/bin"
  "$HOME/.nimble/bin"
  "$HOME/.local/bin"
)

if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
  path=(
    "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
    "$(brew --prefix)/bin" # prefer brew-installed objects to not, possibly breaks things
    $path
  )

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi

[ -d /usr/share/doc/fzf ] && {
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
}


# ----- Prompt
if [ -f "$HOME/.company/.zsh_prompt" ]; then source "$HOME/.company/.zsh_prompt"
elif [ -f "$HOME/.zsh_prompt" ]; then source "$HOME/.zsh_prompt";
fi

bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd 'cc' vi-change-whole-line
bindkey -M vicmd 'C-r' history-inc-search

# I think I just prefer always having block mode...
_blinking_block() { echo -ne '\e[1 q' }
precmd_functions+=( _blinking_block   )

unsetopt correct_all
unsetopt BEEP

# ----- Keep the forwarded SSH agent reachable from workspace.sh containers
# run.sh binds /host$SSH_AUTH_SOCK into the container (env/build/run.sh:828) and
# only repoints it on `workspace.sh connect`. To survive host SSH reconnects in a
# long-running container, keep a stable RELATIVE symlink (ln -sr, so it resolves
# under /host inside the container) at the live socket, and hand run.sh that path.
# Gated on $SSH_CONNECTION: only on the remote, never the laptop or in a container.
_CE_AGENT_LINK="$HOME/.ssh/agent.sock"
_ce_sync_agent() {
  [[ -n "$SSH_CONNECTION" ]] || return
  # Remember the real forwarded socket the first time we hold it; it survives the
  # export below so a later prompt can still repoint a dead link without relying
  # on the tmux env still carrying the real value.
  # NOTE: intentionally global (no `local`) — must persist across precmd calls.
  if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" != "$_CE_AGENT_LINK" && -S "$SSH_AUTH_SOCK" ]]; then
    _CE_REAL_AUTH_SOCK="$SSH_AUTH_SOCK"
  fi
  # (Re)point the link only when it's dead/missing, from the remembered socket.
  if [[ ! -S "$_CE_AGENT_LINK" && -S "$_CE_REAL_AUTH_SOCK" ]]; then
    ln -srf "$_CE_REAL_AUTH_SOCK" "$_CE_AGENT_LINK"
  fi
  # Must be the last writer of SSH_AUTH_SOCK in the prompt, so workspace.sh/run.sh
  # bind the stable path (env/build/run.sh:828) rather than a volatile /tmp socket.
  [[ -S "$_CE_AGENT_LINK" ]] && export SSH_AUTH_SOCK="$_CE_AGENT_LINK"
}
# Primary hook: the login shell holds the real socket on each reconnect.
_ce_sync_agent

# ----- Reset the tmux X11 display / agent socket if necessary
if [ -n "$TMUX" ]; then
  update_tmux_env() {
    eval "$(tmux show-environment -s DISPLAY 2>/dev/null)"       # pull fresh values
    eval "$(tmux show-environment -s SSH_AUTH_SOCK 2>/dev/null)" # pull fresh values
    _ce_sync_agent                                               # then pin to stable (last write wins)
  }

  precmd_functions+=(update_tmux_env)
fi

# ----- Command setup
[ -e "$HOME/.nix-profile/etc/profile.d/nix.sh" ] && . "$HOME/.nix-profile/etc/profile.d/nix.sh" # added by Nix installer
[ -f "$HOME/.ghcup/env"      ] && source "$HOME/.ghcup/env" # ghcup-env
[ -f "$HOME/.cargo/env"      ] && source "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/mise" ] && {
  eval "$(/home/anup/.local/bin/mise activate zsh)"
  path+="$HOME/.local/share/mise/shims"
}

# for "Don't clear screen", use "LESS=X$LESS", for "don't chop lines", use LESS="$LESS -+S"
export LESS='FRS --mouse'


# we like scratch work, and we like being able to execute the current directory (which can be scary)
path+=./._tmp
path+=.

export PATH

# Always cd -P, use -L to override
setopt CHASE_LINKS
