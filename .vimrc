" Reload on save
augroup Reload|autocmd!
  autocmd BufWritePost ~/.{,g}vimrc
        \ source $MYVIMRC | source $MYGVIMRC | nohlsearch |
        \ redraw | echo "vimrc reloaded"
augroup end

setglobal nocompatible
filetype plugin indent on
syntax on

" General
set tabstop=4
set number relativenumber signcolumn=number
setglobal ignorecase smartcase
setglobal shiftround autoindent smartindent
set colorcolumn=121
augroup cursorline|autocmd!
  autocmd BufEnter,WinEnter * setlocal cursorline
  autocmd WinLeave *          setlocal nocursorline
augroup end
set timeoutlen=400

" Files
setglobal autoread
set noswapfile
set undofile undodir=~/.vim/undo
set nowritebackup

let mapleader=" "

" Search
setglobal hlsearch
setglobal incsearch
nnoremap <silent> <Esc><Esc> <Cmd>nohlsearch<Bar>:echo<CR>
vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>
setglobal grepprg=rg\ --vimgrep
setglobal grepformat^=%f:%n:%c:%m
setglobal shortmess-=S shortmess+=s

function! Grep(...)
  " return system(join([&grepprg] + a:000), ' '))
  " let s:cli = join([&grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  let s:rg_args = join(a:000) " for display
  return system(join([&grepprg] + [s:rg_args]))
endfunction
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)
augroup quickfix|autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow |
          \ call setqflist([], 'a', {'title': (exists("s:rg_args") && '$ rg ' . s:rg_args)})
    autocmd QuickFixCmdPost lgetexpr lwindow |
          \ call setloclist(0, [], 'a', {'title': (exists("s:rg_args") && '$ rg ' . s:rg_args)})
augroup end

" FZF
let &runtimepath.="," . ($HOMEBREW_PREFIX ?? "/usr/local") . "/opt/fzf"
function s:files()
  if empty(FugitiveGitDir())
    :Files
  else
    :GFiles
  endif
endfunction
nmap <C-P> <Cmd>call <SID>files()<CR>
nmap <C-U> <Cmd>Buffers<CR>
nmap <C-G> <Cmd>Tags<CR>

" Command line and status line
setglobal ruler showcmd
setglobal laststatus=2
setglobal wildmenu wildmode=longest:full,full wildoptions=pum

" Folds
set foldlevelstart=99 foldmethod=syntax

" Show unwanted chars
set list listchars=tab:›\ ,trail:·,nbsp:·,precedes:«,extends:»

" Consistency
nmap Y y$

" Undo on newline
inoremap <CR> <C-G>u<CR>

" Tab & Windows nav
setglobal splitright splitbelow
nmap <Leader><Leader> <C-^>
autocmd VimResized * wincmd =

nmap <Leader>v <Cmd>vsplit<CR>
nmap <Leader>s <Cmd>split<CR>

nmap H <Cmd>tabprevious<CR>
nmap L <Cmd>tabnext<CR>

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Indent with two spaces
autocmd FileType json,vim setlocal expandtab shiftwidth=2

" Ruby
autocmd FileType ruby  setlocal iskeyword+=?,! formatoptions-=o makeprg=ruby\ %
autocmd FileType ruby  nmap <buffer> <Leader>e oend<Esc>
autocmd FileType ruby  vmap <buffer> <Leader>e >`>oend<Esc>
autocmd FileType ruby  nmap <buffer> <Leader>d odebugger<Esc>
autocmd FileType ruby  nmap <buffer> <Leader>D Odebugger<Esc>
autocmd FileType eruby nmap <buffer> <Leader>e o<% end %><Esc>
autocmd FileType eruby vmap <buffer> <Leader>e >`>o<% end %><Esc>
autocmd FileType ruby  nmap <buffer> <Leader>i i.inspect<Esc>
autocmd FileType ruby  vmap <buffer> <Leader>i S)ip<Esc>
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0
command -range IRB terminal ++close irb

" Rust
autocmd FileType rust compiler cargo
autocmd FileType rust set makeprg=cargo\ test

" Git
autocmd FileType gitcommit setlocal spell formatoptions+=aq nojoinspaces
autocmd FileType gitcommit startinsert
autocmd FileType git nmap <buffer> <Leader>f <Cmd>let @*=expand("%:t")<CR>:echo @*<CR>
nmap <leader>G <Cmd>tab G<CR>
nmap <leader>g :G<Space>
nmap <leader>l <Cmd>G blame<CR>
nmap <leader>L <Cmd>GcLog %<CR>
let g:fugitive_legacy_commands = 0

" Markdown
autocmd FileType markdown setlocal wrap linebreak nojoinspaces

" GitHub
nmap <leader>b <Cmd>GBrowse<CR>
vmap <leader>b :GBrowse!<CR>
vmap <leader>B <Cmd>GBrowse<CR>

" Mappings
nmap <D-F> :Grep<Space><C-R>=expand("<cword>")<CR>
vmap <D-F> y:Grep -F<Space>'<C-R>"'<CR>
cmap %% <C-R>=expand("%:p:h") . "/" <CR>
"" Select last pasted text, with proper visual mode
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
xnoremap . :normal.<CR>
nmap _ <Cmd>Switch<CR>
"" copy file path
nmap <leader>f :let @+=@%<CR>:echo @+<CR>
nmap <leader>F :let @+=expand("%:p")<CR>:echo @+<CR>
vmap <leader>f :<C-U>let @+=expand("%").":".line("v")<CR>:echo @+<CR>
vmap <leader>F :<C-U>let @+=expand("%:p").":".line("v")<CR>:echo @+<CR>
"" cd in current file directory, allow to edit
nmap <leader>c :cd <C-R>=expand("%:p:h")<CR>/
"" turns :E into :e
cabbrev E e
nmap { <Cmd>keepjumps normal! {<CR>
nmap } <Cmd>keepjumps normal! }<CR>
"" don't clobber unnamed register content when pasting in visual mode, P to swap
vnoremap p P
vnoremap P p

" vim-test
let test#strategy = "terminal"
let g:test#preserve_screen = 1
nmap <leader>t <Cmd>TestNearest<CR>
nmap <leader>T <Cmd>TestFile<CR>
nmap <leader>r <Cmd>TestLast<CR>

" ALE
let g:ale_linters = {}
let g:ale_linters.ruby = ["ruby"]
let g:ale_linters.eruby = ["erubi"]
let g:ale_fixers = {}
let g:ale_fixers.ruby = ["rubocop"]
let g:ale_ruby_rubocop_executable = 'bundle'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '✘'
nmap [a <Cmd>ALEPreviousWrap<CR>
nmap ]a <Cmd>ALENextWrap<CR>
nmap <Leader>ad <Cmd>ALEDisable<CR>
nmap <Leader>ae <Cmd>ALEEnable<CR>
nmap <Leader>af <Cmd>ALEFix<CR>

" Move lines up&down
nmap <M-Up>   :move -2<CR>=j
nmap <M-Down> :move +1<CR>=kj
vmap <M-Up>   :move '<-2<CR>gv=gv
vmap <M-Down> :move '>+1<CR>gv=gv

let macvim_skip_cmd_opt_movement = 1

" sort
command Sort normal vii:sort<CR>

" quicklist
nmap <Leader>j :copen 20<CR><C-w>J
packadd cfilter

" Prevent menus
let g:solarized_menu = 0
let g:netrw_menu = 0
let g:netrw_use_errorwindow = 0

" Netrw
augroup Netrw|autocmd!
  autocmd FileType netrw silent! nunmap <buffer> <c-l>
  autocmd FileType netrw nmap <buffer> <D-F> :Grep<Space>
augroup end

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

function s:gitVimrc()
  let s:gitDir = FugitiveGitDir()
  if !empty(s:gitDir) && filereadable(s:gitDir . '/vimrc')
    execute "source" s:gitDir . '/vimrc'
  endif
endfunction
augroup ProjectSpecific|autocmd!
  autocmd! BufReadPost,BufNewFile * call <SID>gitVimrc()
augroup end

" local
if filereadable(expand('~/.vim/local.vimrc'))
  source ~/.vim/local.vimrc
endif
