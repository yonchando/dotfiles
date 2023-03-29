call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'preservim/nerdtree'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'StanAngeloff/php.vim'
Plug 'arnaud-lb/vim-php-namespace'
call plug#end()

syntax enable

let mapleader = " "
set scrolloff=5
set incsearch
set hlsearch
set number
set relativenumber
set tabstop=4
set belloff=all
set visualbell
set noerrorbells
set showmode

"----------------Visuals-----------------"
set t_CO=256
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

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
nmap <Leader>, <C-w><
nmap <Leader>= <C-w>=

"------------- Vim PHP Namespace ---------"
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>i <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>i :call PhpInsertUse()<CR>


"------------- Vinegar ------------------"
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

"------------- EasyMotion Map ------------------"
nmap <Leader>j <Plug>(easymotion-sn)

"----------------NERDTreeToggle-----------"
map <Leader><TAB> :NERDTreeToggle<CR>
map <Leader>f :NERDTreeFind<CR>


"----------------Auto Command---------------"
autocmd BufWritePost .vimrc source %
