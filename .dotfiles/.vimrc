syntax enable

let mapleader = " "

set encoding=UTF-8

set incsearch
set hlsearch

set number
set relativenumber

set belloff=all
set visualbell
set noerrorbells

set showmode

set scrolloff=5
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent

set colorcolumn=80

set noswapfile

set undofile
set undodir=~/.vim/undodir


set guicursor=""

"----------------Mapping-----------------"
map Q gq
map H b
map L e
map J 3jzz
map K 3kzz
map <leader>/ :nohl<CR>
map <leader>q :wqa<CR>
map <A-w> :bd<CR>

" Normal Map
nmap <leader>sp :sp<cr>
nmap <leader>vsp :vsp<cr>

nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <leader>. <C-w>>

nmap <leader><tab> :Exp<CR>
nmap <A-1> :Exp<CR>

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz


"----------------Auto Command---------------"
autocmd BufWritePost .vimrc source %
