#!/usr/bin/env bash
set -e # Trap exits
set -u # Error on unset vars

unameOut="$(uname -s)"

case "${unameOut}" in
Darwin*)
	echo "Installing Homebrew..." && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" </dev/null
	brew update >/dev/null
	export HOMEBREW_NO_AUTO_UPDATE=1
	echo "-> Installing latest git..." && (brew install git)
	echo "-> Installing latest zsh..." && (brew install zsh)
	sudo sh -c "echo $(brew --prefix)/bin/zsh >> /etc/shells"
	echo "-> Installing homeshick..." && (git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick" >/dev/null)

	echo "-> Installing oh-my-zsh..." && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	# Note, oh-my-zsh doesn't like a .zshrc existing already, so we do this after!
	"$HOME/.homesick/repos/homeshick/bin/homeshick" clone anup-the-magic/castle

	echo "  -> Installing powerlevel10k..." && (git clone https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" >/dev/null)
	echo "  -> Installing .purepower..." && (cd && curl -fsSLO https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower)
	echo "Swapping to ZSH!" && eval -l "$(grep /zsh$ /etc/shells | tail -1)"

	echo "-> Installing latest vim and nvim..." && (brew install vim neovim)
	echo "-> Installing vim-plug..." && curl -fLosS ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	echo "-> Installing gnu-sed..." && (brew install gnu-sed)
	echo "-> Installing gawk..." && (brew install gawk)

	echo "-> Installing tmux plugin manager..." && (git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm >/dev/null)

	echo "-> Installing asdf..." && (brew install asdf)
	echo "-> Installing fasd..." && (brew intall fasd)
	echo "-> Installing jq..." && (brew install jq)
	echo "-> Installing gron..." && (brew install gron)
	echo "-> Installing thefuck..." && (brew install thefuck)

	echo "-> Installing shfmt + shellcheck..." && (brew install shfmt shellcheck)
	unset HOMEBREW_NO_AUTO_UPDATE
	;;
Linux*)
	# TODO: Add -y to apt commands, reorganize
	echo "Updating apt" && (sudo apt update)
	echo "Installing git,zsh,tmux" && (sudo apt install git zsh tmux)
	echo "Changing to zsh" && (chsh -s `which zsh`)

	echo "-> Installing homeshick..." && (git clone git://github.com/andsens/homeshick.git "$HOME/.homesick/repos/homeshick")
	"$HOME/.homesick/repos/homeshick/bin/homeshick" clone anup-the-magic/castle

	echo "-> Installing oh-my-zsh..." && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" "--keep-zshrc"

	echo "-> Installing tmux plugin manager..." && (git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm)
	echo "  -> Manually triggering a plugin install" && (~/.tmux/plugins/tpm/bindings/install_plugins)
	echo "-> Installing vim/nvim" && (sudo apt install vim neovim)

	echo "-> Installing ripgrep" && (sudo apt install ripgrep)
	echo "-> Installing fzf" && (sudo apt install fzf)
	;;
# CYGWIN*)	machine=Cygwin;;
# MINGW*)	 machine=MinGw;;
*) echo "Unable to detect OS Version: ($unameOut) is not set up for this install script" >&2 && exit 1 ;;
esac
