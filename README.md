# dotfiles
## Installation

```bash
# clone me
$ cd ~
$ git clone git@github.com:kitakitabuer/dotfiles.git
$ cd dotfiles

# install dotfiles
$ sh symlink.sh

# download plug.vim
$ curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# install plugins in vim-console
:PlugInstall
```
