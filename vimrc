" Reload on save
augroup Reload|autocmd!
  autocmd BufWritePost .vimrc,vimrc source $MYVIMRC|echo "vimrc reloaded"
augroup end

set nocompatible
filetype plugin indent on

" General
set tabstop=4
set shiftwidth=0
set shiftround
set smarttab
set autoindent
set smartindent
set number
set ignorecase
set smartcase
set colorcolumn=121
set relativenumber

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

set runtimepath+=/usr/local/opt/fzf
nmap <C-P> :GFiles<CR>
nmap <D-P> :FZF<CR>
nmap <C-U> :Buffers<CR>

" Status bar
set ruler
set showcmd
set laststatus=2
set wildmenu

" Show unwanted chars
set listchars=tab:›\ ,trail:·,nbsp:·,precedes:«,extends:»
set list

" Consistency
nmap Y y$

" Undo on newline
inoremap <CR> <C-G>u<CR>

" Tab & Windows nav
set splitright
set splitbelow
nmap <Leader><Leader> <C-^>

nmap <Leader>v :vsplit<CR>
nmap <Leader>s :split<CR>

nmap H :tabprevious<CR>
nmap L :tabnext<CR>
nmap <S-D-Left> :tabprevious<CR>
nmap <S-D-Right> :tabnext<CR>

nmap <C-H> <C-W>h
nmap <C-L> <C-W>l
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k

nmap <D-Left> <C-W>h
nmap <D-Right> <C-W>l
nmap <D-Down> <C-W>j
nmap <D-Up> <C-W>k

" Ruby
autocmd FileType ruby setlocal iskeyword+=?,! formatoptions-=o makeprg=ruby\ %
autocmd FileType ruby map <buffer> <Leader>e oend<Esc>
autocmd FileType ruby vmap <buffer> <Leader>e >gv<Esc>oend<Esc>
autocmd FileType eruby map <buffer> <Leader>e o<% end %><Esc>
autocmd FileType ruby nmap <buffer> <Leader>i i.inspect<Esc>
let g:ruby_indent_assignment_style = 'variable'

" Rust
autocmd FileType rust compiler cargo
autocmd FileType rust set makeprg=cargo\ test

" Git
autocmd FileType gitcommit setlocal spell
nmap <leader>g :e .git/index<CR>

" JSON
autocmd FileType json setlocal expandtab shiftwidth=2

" GitHub
nmap <leader>b :Gbrowse<CR>
vmap <leader>b :Gbrowse!<CR>
vmap <leader>B :Gbrowse<CR>

" Mappings
nmap <D-F> :Ag<Space>
vmap <D-F> y:Ag<Space>'<C-R>"'<CR>
cmap %% <C-R>=expand("%:p:h") . "/" <CR>
"" Select last pasted text, with proper visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap . :normal.<CR>
nmap _ :Switch<CR>
"" copy file path
nmap <leader>f :let @+=@%<CR>:echo "<C-R>+"<CR>
vmap <leader>f :<C-U>let @+="<C-R>=expand("%").":".expand(line("v"))<CR>"<CR>:echo "<C-R>+"<CR>
"" cd in current file directory, allow to edit
nmap <leader>c :cd <C-R>=expand("%:p:h")<CR>/

" vim-test
let test#strategy = "terminal"
let g:test#preserve_screen = 1
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>r :TestLast<CR>

" TextMate Enter
imap <D-CR> <Esc><D-CR>
imap <S-D-CR> <Esc>O
map <D-CR> A<CR>

" auto-pairs
let g:AutoPairsOnlyWhitespace = 1

" sort
command Sort normal vii:sort<CR>

" filter quicklist
packadd cfilter

" local
if filereadable(expand('~/.vim/local.vimrc'))
  source ~/.vim/local.vimrc
endif
