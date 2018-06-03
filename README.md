# dotfiles
## Deploy dotfiles

* Emacs
``` bash
ln -s ~/dotfiles ~/.emacs.d/init.el
```

## Emacs: init.el
### Pre-installation process
1. Eval <package-refresh-contents>
2. Apt operation
``` bash
sudo apt install emacs-mozc llvm-dev clang libclang-dev cmake
```
3. Install SourceHansansHWJ
   3.1. Download https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SourceHanSansHWJ.zip
   3.2. unzip
   3.3. cp *.otf ~/.fonts
   3.4. fc-cache
4. Emacs operation
   4.1. M-x jedi:install-server
   4.2. M-x irony-install-server









