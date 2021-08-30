filetype plugin indent on
syntax enable

set autoread
set background=dark " CHANGE ME
set backspace=indent,eol,start
set colorcolumn=80
set diffopt=foldcolumn:0,filler
set equalalways
set fillchars=vert:┃,fold:·,diff:\ 
set foldmethod=syntax
set foldnestmax=2
set hidden
set history=1000
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set list
set listchars=trail:·
set mouse=a
set nobackup
set noshowmode
set noswapfile
set numberwidth=1
set path=.,**
set scrolloff=5
set shiftwidth=2
set showtabline=2
set signcolumn=yes
set smartcase
set splitbelow
set splitright
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,
  \.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg
set termguicolors
set wildmenu
if has('nvim')
  set inccommand=split
endif
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
let mapleader = "\<Nop>"
let g:vimsyn_folding='af'
let g:markdown_folding = 1
let g:markdown_fenced_languages = [
  \'css',
  \'javascript',
  \'js=javascript',
  \'jsx=javascript',
  \'.jsx=javascript',
  \'json',
  \'ruby',
  \'sass',
  \'xml',
  \]

augroup interface
  autocmd!
  autocmd BufEnter,FileType * call clearmatches()
    \| if &ft == 'markdown' | call matchadd('markdownRule', '\s\+$') | endif
    \| call matchadd('ErrorMsg', &ft == 'markdown' ? '\(\S\s\s\)\?\zs\s*$' : '\s\+$')
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd VimResized,WinNew * wincmd =
  autocmd WinEnter * setlocal winwidth=80 | wincmd =
  autocmd WinLeave * setlocal winwidth=20
  autocmd CmdlineEnter / setlocal nofoldenable
  autocmd CmdlineLeave / setlocal foldenable | normal zv
augroup END

augroup clipboard
  au TextYankPost *
    \  if v:event.regname==''&&v:event.operator=='y'
    \|   let @+=join(v:event.regcontents, "\n")
    \| endif
augroup END

" cursor style
if !has('nvim')
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
  silent !echo -ne "\033[2 q"
  autocmd VimLeave * silent !echo -ne "\033[6 q"
else
  autocmd VimLeave * set guicursor=a:ver25-blinkon25
endif

" persistent undo
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" custom fold
function! CustomFoldText()
  return getline(v:foldstart) . ' '
endfunction
set foldtext=CustomFoldText()
