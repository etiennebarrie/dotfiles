" Reload on save
autocmd BufWritePost ?vimrc source $MYVIMRC

set nocompatible
filetype plugin indent on

" File navigation
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" General
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab
set smarttab
set autoindent
set smartindent
set number
set ignorecase
set smartcase
set colorcolumn=121

" Files
set autoread
set noswapfile
set undofile
set undodir=~/.vim/undo
set wildignore=*/tmp/*

let mapleader=" "

" Search
set hlsearch
set incsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>:echo<CR>

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
nmap <Leader><Leader> <C-^>

nmap H :tabprevious<CR>
nmap L :tabnext<CR>
nmap <S-D-Left> :tabprevious<CR>
nmap <S-D-Right> :tabnext<CR>

nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

nnoremap <D-Left> <C-W>h
nnoremap <D-Right> <C-W>l
nnoremap <D-Down> <C-W>j
nnoremap <D-Up> <C-W>k

" Ruby
autocmd FileType ruby setlocal iskeyword+=?,!
autocmd FileType ruby map <buffer> <Leader>e oend<ESC>
autocmd FileType eruby map <buffer> <Leader>e o<% end %><ESC>

" Rust
autocmd FileType rust compiler cargo
autocmd FileType rust set makeprg=cargo\ test

" Git
autocmd FileType gitconfig setlocal noexpandtab
autocmd FileType gitconfig setlocal tabstop=4

" Mappings
nmap <D-F> :Ag<Space>
vmap <D-F> y:Ag<Space>'<C-r>"'<CR>
cmap %% <C-R>=expand("%:p:h") . "/" <CR>
"" Select last pasted text, with proper visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
nnoremap - :Switch<cr>
xnoremap . :normal.<cr>

" vim-test
let test#strategy = "terminal"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>

" TextMate Enter
imap <D-CR> <Esc><D-CR>
imap <S-D-CR> <Esc>O
map <D-CR> A<CR>

" auto-pairs
let g:AutoPairsOnlyWhitespace = 1
