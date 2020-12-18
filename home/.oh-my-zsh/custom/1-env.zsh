if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
fi

bindkey -v
export KEYTIMEOUT=10
bindkey -M viins 'jk' vi-cmd-mode

if $LOADED_PATH; then
  export LOADED_PATH=true
  TEMP_PATH=(
    /usr/local/bin
    $GNU_SED_PATH

    # --------------- DEFAULT_PATH
    $PATH
    # --------------- END DEFAULT_PATH

    $HOME/bin
    /usr/local/sbin
    $HOME/.nim/bin
    $HOME/Library/Haskell/bin
    $HOME/.nimble/bin
    $HOME/.local/bin
    ./._tmp
    .
  )
  export PATH=${(j/:/)TEMP_PATH}
fi

export EDITOR='nvim'
if [ -e /home/anup/.nix-profile/etc/profile.d/nix.sh ]; then . /home/anup/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
