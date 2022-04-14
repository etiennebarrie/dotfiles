" Reload on save
augroup Reload|autocmd!
  autocmd BufWritePost {,.,g,.g}vimrc
        \ source $MYVIMRC | source $MYGVIMRC |
        \ redraw | echo "vimrc reloaded"
augroup end

set nocompatible
filetype plugin indent on

" General
set autoindent
set smartindent
set number
set ignorecase
set smartcase
set tabstop=4
set colorcolumn=121
set relativenumber
set signcolumn=number
augroup cursorline|autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd WinLeave *          setlocal nocursorline
augroup end

" Files
set autoread
set noswapfile
set undofile
set undodir=~/.vim/undo

let mapleader=" "

" Search
set hlsearch
set incsearch
nnoremap <silent> <Esc><Esc> :nohlsearch<Bar>:echo<CR>
vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>

let &runtimepath.="," . ($HOMEBREW_PREFIX ?? "/usr/local") . "/opt/fzf"
function s:files()
	if empty(FugitiveGitDir())
		:Files
	else
		:GFiles
	endif
endfunction
nmap <silent> <C-P> :call <SID>files()<CR>
nmap <C-U> :Buffers<CR>

" Command line and status line
set ruler
set showcmd
set laststatus=2
setglobal wildmenu wildmode=longest:full,full

" Folds
set foldlevelstart=99
set foldmethod=syntax

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

" Indent with two spaces
autocmd FileType json,vim setlocal expandtab shiftwidth=2

" Ruby
autocmd FileType ruby setlocal iskeyword+=?,! formatoptions-=o makeprg=ruby\ %
autocmd FileType ruby map <buffer> <Leader>e oend<Esc>
autocmd FileType ruby vmap <buffer> <Leader>e >`>oend<Esc>
autocmd FileType eruby map <buffer> <Leader>e o<% end %><Esc>
autocmd FileType eruby vmap <buffer> <Leader>e >`>o<% end %><Esc>
autocmd FileType ruby nmap <buffer> <Leader>i i.inspect<Esc>
autocmd FileType ruby vmap <buffer> <Leader>i S)ip<Esc>
autocmd FileType ruby nmap <buffer> <A-Up> ^[mw
autocmd FileType ruby nmap <buffer> <A-Down> ]mw
autocmd FileType ruby nmap <buffer> <S-A-Up> ^[[w
autocmd FileType ruby nmap <buffer> <S-A-Down> ]]w
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0

" Rust
autocmd FileType rust compiler cargo
autocmd FileType rust set makeprg=cargo\ test

" Git
autocmd FileType gitcommit setlocal spell
autocmd FileType gitcommit startinsert
nmap <leader>G :e <C-R>=trim(system("git rev-parse --git-dir"))<CR>/index<CR>
nmap <leader>g :G<Space>
nmap <leader>l :G blame<CR>

" GitHub
nmap <leader>b :GBrowse<CR>
vmap <leader>b :GBrowse!<CR>
vmap <leader>B :GBrowse<CR>

" Mappings
nmap <D-F> :Ag<Space>
vmap <D-F> y:Ag -F '<C-R>"'<CR>
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

" Syntastic
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_error_symbol = "✘"
let g:syntastic_warning_symbol = "✘"

" TextMate Enter
imap <D-CR> <Esc><D-CR>
imap <S-D-CR> <Esc>O
map <D-CR> A<CR>

" auto-pairs
let g:AutoPairsOnlyWhitespace = 1

" sort
command Sort normal vii:sort<CR>

" quicklist
nmap <Leader>j :copen 20<CR><C-w>J
packadd cfilter

" Prevent menus
let g:solarized_menu=0
let g:DrChipTopLvlMenu = "" " Align
let g:netrw_menu = 0

" local
if filereadable(expand('~/.vim/local.vimrc'))
  source ~/.vim/local.vimrc
endif
