setlocal iskeyword+=?,!
setlocal makeprg=ruby\ %
nmap <buffer> <Leader>e ==oend<Esc>
vmap <buffer> <Leader>e >`>oend<Esc>
nmap <buffer> <Leader>E >>oend<Esc>kO do<Esc>`[i
nmap <buffer> <Leader>d odebugger<Esc>
nmap <buffer> <Leader>D Odebugger<Esc>
nmap <buffer> <Leader>i i.inspect<Esc>
vmap <buffer> <Leader>i S)ip<Esc>
"" copy and accumulate in @m joined with :: (i.e. copy nested module names)
nmap <buffer> <Leader>M "myiW<Cmd>echo @m<CR>
nmap <buffer> <Leader>m <Cmd>silent let @m.='::'<CR>"MyiW<Cmd>echo @m<CR>
vmap <buffer> <Leader>m <Cmd>let @m.='::'<CR>"My<Cmd>echo @m<CR>
let g:ruby_indent_assignment_style = 'variable'
let g:ruby_indent_hanging_elements = 0
