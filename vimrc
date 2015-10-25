" Reload on save
autocmd BufWritePost ?vimrc source $MYVIMRC

" Vundle setup
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'Align'
Plugin 'AndrewRadev/switch.vim'
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'nixprime/cpsm'
Plugin 'rking/ag.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-surround'

call vundle#end()
filetype plugin indent on

" General
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab
set number
set ignorecase
set smartcase

" Files
set autoread
set noswapfile
set undofile
set undodir=~/.vim/undo
set wildignore=*/tmp/*

let mapleader=","

" Search
set hlsearch
set incsearch
nmap <leader>/ :nohlsearch<CR>

" Status bar
set ruler
set showcmd
set laststatus=2

" Show unwanted chars
set listchars=tab:»\ ,trail:·,nbsp:·
set list
highlight NonText guifg=gray
highlight SpecialText guifg=gray

" Consistency
nmap Y y$

" Tab & Windows nav
set splitright
set splitbelow
nmap H :tabprevious<CR>
nmap L :tabnext<CR>
nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

" Ruby
autocmd FileType ruby setlocal iskeyword+=?,!

" Mappings
nmap <D-F> :Ag 
cmap %% <C-R>=expand("%:p:h") . "/" <CR>
"" Select last pasted text, with proper visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap - :Switch<cr>

" cpsm
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
