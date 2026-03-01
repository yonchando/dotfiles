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
map J 3jzz
map K 3kzz
map <leader>/ :nohl<CR>
map <leader>q :wqa<CR>
map <A-w> :bd<CR>
map <leader><tab> :Exp<CR>

" Normal Map
nmap <Leader>sp :sp<cr>
nmap <Leader>vsp :vsp<cr>
nmap <C-l> <C-w>l
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <Leader>. <C-w>>

nmap <C-d> <C-d>zz
nmap <C-u> <C-u>zz


"----------------Auto Command---------------"
autocmd BufWritePost .vimrc source %
