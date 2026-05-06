function! test#ruby#cruby#executable() abort
  return 'make'
endfunction

if !exists('g:test#ruby#cruby#file_pattern')
  let g:test#ruby#cruby#file_pattern = '\v(((^|/)test_.+)|_test|_spec)\.rb$'
endif

function! test#ruby#cruby#test_file(file) abort
  return a:file =~# g:test#ruby#cruby#file_pattern
endfunction

function! test#ruby#cruby#build_position(type, position) abort
  if a:type ==# 'nearest'
    let name = s:nearest_test(a:position)
    if !empty(name)
      let flag = s:is_spec(a:position['file']) ? '-e' : '--name'
      return [a:position['file'], flag, name]
    else
      return [a:position['file']]
    endif
  elseif a:type ==# 'file'
    return [a:position['file']]
  else
    return []
  endif
endfunction

function! test#ruby#cruby#build_args(args) abort
  for idx in range(0, len(a:args) - 1)
    if test#base#file_exists(a:args[idx])
      let path = remove(a:args, idx) | break
    endif
  endfor

  if exists('path') && isdirectory(path)
    let path = fnamemodify(path, ':p:.') . '**/{test_*,*_test}.rb'
  elseif !exists('path')
    let path = 'test/**/{test_*,*_test}.rb'
  endif

  let var = s:is_spec(path) ? 'SPECOPTS' : 'TESTOPTS'

  if var ==# 'TESTOPTS'
    for option in ['--name', '--seed']
      let idx = index(a:args, option)
      if idx != -1
        let value = remove(a:args, idx + 1)
        let a:args[idx] = option.'='.value
      endif
    endfor
  endif

  return s:build_make_args(path, a:args, var)
endfunction

function! s:build_make_args(path, args, var) abort
  let cmd = []
  if !empty(a:path) | call add(cmd, a:path) | endif
  if !empty(a:args)
    let parts = map(copy(a:args), 's:dq(v:val)')
    let opts = substitute(join(parts), '\$', '$$', 'g')
    call add(cmd, a:var.'='.shellescape(opts, 1))
  endif
  return cmd
endfunction

function! s:dq(str) abort
  if a:str =~# '\v^[a-zA-Z0-9_./=:,+@%#-]+$'
    return a:str
  endif
  return '"'.escape(a:str, '"\$`').'"'
endfunction

function! s:is_spec(file) abort
  return a:file =~# '\v_spec\.rb$'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#ruby#patterns)
  if s:is_spec(a:position['file'])
    return empty(name['test']) ? '' : name['test'][0]
  endif
  let namespace = filter([join(name['namespace'], '::')], '!empty(v:val)')
  let test = empty(name['test']) ? [] : [name['test'][0]]
  return join(namespace + test, '#')
endfunction
