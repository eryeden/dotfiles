# dotfiles
## Deploy dotfiles

* Emacs
``` bash
ln -s ~/dotfiles ~/.emacs.d/init.el
```

## Emacs: init.el
### Pre-installation process
1. Apt operation
``` bash
sudo apt install emacs-mozc llvm-dev clang libclang-dev cmake
pip isntall virtualenv
```

2. Install SourceHansansHWJ
   1. Download https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SourceHanSansHWJ.zip
   2. unzip
   3. cp *.otf ~/.fonts
   4. fc-cache

3. Emacs operation
``` emacs-lisp
M-x package-refresh-contents
M-x jedi:install-server
M-x irony-install-server
```










