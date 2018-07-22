command! -range=% AlignFirstSpace  :<line1>,<line2>Tabularize /^\s*[^ ]*\zs\s/l0
command! -range=% AlignSecondSpace :<line1>,<line2>Tabularize /^\s*[^ ]*\s[^ ]*\zs\s/l0
command! -range=% AlignThirdSpace  :<line1>,<line2>Tabularize /^\s*[^ ]*\s[^ ]*\s*[^ ]*\zs\s/l0

function! Center()
  exec "center" len(getline(a:firstline-1))
endfunction
command! -range Center <line1>,<line2>call Center()

command! Cd :cd %:h
command! Save :call mkdir(expand('%:h'), 'p') | save %:p

function! Redir(cmd)
  for win in range(1, winnr('$'))
    if getwinvar(win, 'scratch')
      execute win . 'windo close'
    endif
  endfor
  if a:cmd =~ '^!'
    execute "let output = system('" . substitute(a:cmd, '^!', '', '') . "')"
  else
    redir => output
    execute a:cmd
    redir END
  endif
  vnew
  let w:scratch = 1
  setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile
  call setline(1, split(output, "\n"))
endfunction
command! -nargs=1 Redir silent call Redir(<f-args>)

if executable('curl') && executable('tr') && executable('xclip')
  command! -range=% Ix  <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
endif

if executable('figlet') && executable('sed')
  command! -range Italic :<line1>,<line2>!figlet -f italic|sed 's/ *$//'
  command! -range Bulbhead :<line1>,<line2>!figlet -f bulbhead|sed 's/ *$//'
endif

