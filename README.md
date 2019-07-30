# dotfiles
## Deploy dotfiles

* Emacs
``` bash
cd ~/.emacs.d/init.el
ln -s ~/dotfiles/init.el .
```

## .bashrc
1. Add bashrc.bash to ~/.bashrc
``` bash
echo "source $HOME/dotfiles/bashrc.bash" >> ~/.bashrc
```

## Emacs: init.el
### Pre-installation process
1. Apt operation
``` bash
sudo apt install emacs-mozc-bin llvm-dev clang libclang-dev cmake
pip isntall virtualenv
```

2. Install SourceHansansHWJ
   1. Download https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SourceHanSansHWJ.zip
   2. unzip
   3. cp *.otf ~/.fonts
   4. sudo fc-cache -fv

3. Emacs operation
``` emacs-lisp
M-x package-refresh-contents
M-x jedi:install-server
M-x irony-install-server
```










