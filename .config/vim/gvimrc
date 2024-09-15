" Appearance
colorscheme solarized
set background=dark
set guifont=SF\ Mono\ Regular:h14
highlight NonText guifg=Gray
highlight SpecialKey guifg=#555555 guibg=bg
highlight link SyntasticErrorSign ErrorMsg
highlight link SyntasticStyleErrorSign ErrorMsg
highlight link SyntasticWarningSign WarningMsg
highlight link SyntasticStyleWarningSign WarningMsg

" Windows and tabs navigation
nmap <C-S-Tab>   <Cmd>tabprevious<CR>
nmap <S-D-Left>  <Cmd>tabprevious<CR>
nmap <C-Tab>     <Cmd>tabnext<CR>
nmap <S-D-Right> <Cmd>tabnext<CR>
nmap <D-Left>    <C-W>h
nmap <D-Down>    <C-W>j
nmap <D-Up>      <C-W>k
nmap <D-Right>   <C-W>l

" TextMate Enter
imap <D-CR>   <Esc><D-CR>
imap <S-D-CR> <Esc>O
nmap <D-CR>   A<CR>
nmap <S-D-CR> kA<CR>

" ⌘ and ⌃ movements for Command-line mode
no! <D-Left>  <Home>
no! <D-Right> <End>
no! <M-Left>  <C-Left>
no! <M-Right> <C-Right>
ino <M-BS>    <C-w>
ino <D-BS>    <C-u>

autocmd FileType ruby nmap <buffer> <S-D-Up>   ^[[w
autocmd FileType ruby nmap <buffer> <S-D-Down> ]]w
