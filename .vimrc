call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
Plug 'tc50cal/vim-terminal'
Plug 'terryma/vim-multiple-cursors'
Plug 'ap/vim-css-color'
Plug 'preservim/tagbar'

Plug 'https://github.com/neoclide/coc.nvim' " For neovim only

call plug#end()

syntax enable

set encoding=UTF-8
let mapleader = " "
set scrolloff=5
set incsearch
set hlsearch
set number
set relativenumber
set tabstop=2
set belloff=all
set visualbell
set noerrorbells
set showmode
set shiftwidth=2

"----------------Mapping-----------------"
map Q gq
map H b
map L e
map J 3j
map K 3k
map <leader>/ :nohl<CR>

" Normal Map
nmap <Leader>sp :sp<cr>
nmap <Leader>vsp :vsp<cr>
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <Leader>. <C-w>>

"------------- Vinegar ------------------"
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"------------- EasyMotion Map ------------------"
nmap <Leader>j <Plug>(easymotion-sn)

"----------------NERDTreeToggle-----------"
let g:NERDTreeDirArrowExpandable="+"
let g:NERDTreeDirArrowCollapsible="~"

map <Leader><TAB> :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>

"----------------Auto Command---------------"
autocmd BufWritePost .vimrc source %
