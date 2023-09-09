# Custom Script for vimrc and ideavim
Plugin and Key Mapping for vimrc and ideavim

## First install Vim-plug for plugin
### [Vim-Plug](https://github.com/junegunn/vim-plug)
Vim-Plug for Install Plug

### Vim-Plug for vim
``` 
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### Vim-Plug for neovim
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### Ctags

#### Ubuntu
``` 
sudo apt-get update && sudo apt-get install -y exuberant-ctags 
```
#### Mac
```
brew install ctags
```
#### CentOs
```
sudo yum update && sudo yum install -y ctags
```

### [Easymotion](https://github.com/easymotion/vim-easymotion)
Easymotion for easy jump to specific text

### [NERDTREE](https://github.com/preservim/nerdtree)
Addon Plugin NERDTree for folder tree listing

### [Vingear](https://github.com/tpope/vim-vinegar)
Addon Plugin Vingear for search and find file

### [CTRL-P](https://github.com/ctrlpvim/ctrlp.vim)
Addon Plugin Vingear for search and find file

### [Vim-Airline](https://github.com/vim-airline/vim-airline)
Vim Airline has tabline in bottom to show Vim mode, line number etc...

### [Vim-Devicons](https://github.com/ryanoasis/vim-devicons)
Vim devicons show icon by extension file in nerdtree and etc...

### [Vim-Multiple-Cursors](https://github.com/terryma/vim-multiple-cursors)
Vim multiple curosrs

### [Vim-css-color](https://github.com/ap/vim-css-color)
Vim css color show color on Hex color in backgroud

### [Tagbar](https://github.com/preservim/tagbar)
Sidebar tab for show Ctags

### [Coc Vim](https://github.com/neoclide/coc.nvim)
Language completion
