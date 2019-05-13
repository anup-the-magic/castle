if (( $+commands[brew] )); then
  GNU_SED_PATH=$(brew --prefix)/opt/gnu-sed/libexec/gnubin
fi

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
export EDITOR='vim'
