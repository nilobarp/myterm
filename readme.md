#Setup steps for my terminal

## Install `zsh`

    apt-get install zsh
    apt-get install git-core

    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh

change shell to zsh

    chsh -s `which zsh`

Restart

    sudo shutdown -r 0

## Plugins

    git clone https://github.com/bling/vim-airline.git ~/.vim/bundle/vim-airline
    git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
    git clone https://github.com/kien/ctrlp.vim.git ~/.vim/bundle/ctrlp.vim
    git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-go
    git clone https://github.com/Shougo/neocomplete.vim.git ~/.vim/bundle/neocomplete.vim

## Color scheme

    wget https://raw.githubusercontent.com/flazz/vim-colorschemes/master/colors/xoria256.vim ~/.vim/colors/xoria256.vim

##golang specific

    :GoInstallBinaries
