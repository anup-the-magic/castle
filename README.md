# Castle -- all mah dotfiles
### Requirements
- [vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
- [tmux-plugin-manager](https://github.com/tmux-plugins/tpm)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
- [brew](http://brew.sh)
```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
- Bash 4.4
```
brew install bash
# Add the new shell to the list of allowed shells
sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
# Change to the new shell
chsh -s /usr/local/bin/bash
```
- [homeshick](https://github.com/andsens/homeshick/wiki/Installation)
```
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
$HOME/.homesick/repos/homeshick/bin/homeshick clone anup-2s/castle
```
- [powerline](https://github.com/powerline/powerline)
```
pip install powerline-status
```
- [nvm](https://github.com/creationix/nvm#installation)
```
brew install nvm
```
(if this causes errors install from source)


### Useful things:
- [thefuck](https://github.com/nvbn/thefuck)
```
brew install thefuck
```
- [powerline-gitstatus](https://github.com/jaspernbrouwer/powerline-gitstatus)
```
pip install powerline-gitstatus
```
- [gitflow-autocomplete](https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion)
- [autojump](https://github.com/wting/autojump)
