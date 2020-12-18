HOMESHICK_SRC="$HOME/.homesick/repos/homeshick/homeshick.sh"
if [[ -f $HOMESHICK_SRC ]]; then
  source $HOMESHICK_SRC
  homeshick --quiet refresh
else
  echo "Warning: Homeshick isn't installed!" >&2
fi

if grep -qEi "microsoft" /proc/version &> /dev/null; then
  alias open="explorer.exe"
fi
