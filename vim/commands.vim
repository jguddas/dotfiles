command! -range=% AlignFirstSpace  :<line1>,<line2>Tabularize /^\s*[^ ]*\zs\s/l0
command! -range=% AlignSecondSpace :<line1>,<line2>Tabularize /^\s*[^ ]*\s[^ ]*\zs\s/l0
command! -range=% AlignThirdSpace  :<line1>,<line2>Tabularize /^\s*[^ ]*\s[^ ]*\s*[^ ]*\zs\s/l0

function! Center()
  exec "center" len(getline(a:firstline-1))
endfunction
command! -range Center <line1>,<line2>call Center()

command! Cd :cd %:h

if executable('curl') && executable('tr') && executable('xclip')
  command! -range=% Ix  <line1>,<line2>w !curl -F 'f:1=<-' ix.io | tr -d '\n' | xclip -i -selection clipboard
endif

if executable('figlet') && executable('sed')
  command! -range Italic :<line1>,<line2>!figlet -f italic|sed 's/ *$//'
  command! -range Bulbhead :<line1>,<line2>!figlet -f bulbhead|sed 's/ *$//'
endif

