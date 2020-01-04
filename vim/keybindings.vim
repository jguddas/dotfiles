" vim:fdm=marker

" dev
nnoremap ..s :source %<CR>
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" remap dot
nnoremap , .
nnoremap . <Nop>

" custom comands
nnoremap ._ :Cd<CR>

" other
nnoremap <BS>   X
nnoremap U      <C-r>
nnoremap Y      y$
xnoremap Y      y$
nnoremap k      Do<esc>p>>k$
nnoremap j      :keeppatterns s/\n\s*/<cr>
xnoremap j      <esc>:keeppatterns '<,'>-s/\n\s*/<cr>
nnoremap <home> g<home>
nnoremap <end>  g<end>
nnoremap <down> gj
nnoremap <up>   gk

" buffer text-object {{{
xnoremap i% :<C-u>let z = @/\|1;/^./kz<CR>G??<CR>:let @/ = z<CR>V'z
onoremap i% :<C-u>normal vi%<CR>
xnoremap a% GoggV
onoremap a% :<C-u>normal va%<CR>
" }}}

" write/edit/quit/read {{{
nnoremap ..q   :qa!<CR>
nnoremap ..x   :wqa!<CR>
nnoremap .w    :write!<CR>
nnoremap .x    :w<CR>:Sayonara!<CR>
nnoremap <C-r> :checktime<CR>

nnoremap <expr>.- ":bd<Bar>Dirvish ".expand("%:h")."<CR>"
nnoremap <expr>.ä ":edit ".expand('%:h')."/"
" }}}

" search {{{
nnoremap ./  /\v\c
nnoremap .?  ?\v\c
nnoremap .m  :s///g<Left><Left>
nnoremap ..m :%s///g<Left><Left>
nnoremap .l  :nohlsearch<CR>
nnoremap \   :grep ""<Left>
xnoremap .m  :s///g<Left><Left>
" }}}

" paste {{{
nnoremap .p "+p
nnoremap .P "+P
xnoremap .p "+p
xnoremap .P "+P
" }}}

" spell {{{
nnoremap .sd :setlocal spell spelllang=de<CR>
nnoremap .se :setlocal spell spelllang=en<CR>
nnoremap .ss :setlocal spell!<CR>
" }}}

" interface {{{

" jumplist
nnoremap <S-Tab> <C-o>

" wildmenu
cnoremap <Left>  <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" buffers
nnoremap ..d :Sayonara!<CR><C-w>c
nnoremap .d  :Sayonara!<CR>
nnoremap .n  :enew<CR>

" buffers
" nnoremap <expr><Tab>   tabpagenr("$") == 1 ? ":bnext<CR>" : ":tabnext<CR>"
" nnoremap <expr><S-Tab> tabpagenr("$") == 1 ? ":bprev<CR>" : ":tabprev<CR>"
nnoremap <C-n>  :bnext<CR>
nnoremap <C-p>  :bprev<CR>
nnoremap .<C-n> :tabnext<CR>
nnoremap .<C-p> :tabprev<CR>

" window
nnoremap .q <C-w>c
nnoremap .o :only<CR>

" focus
nnoremap .u <C-w><Up>
nnoremap .i <C-w><Down>
nnoremap .t <C-w><Left>
nnoremap .e <C-w><Right>

" move
nnoremap .U <C-w>K
nnoremap .I <C-w>J
nnoremap .T <C-w>H
nnoremap .E <C-w>L

" split
nnoremap .v :vsplit<CR>
nnoremap .h :split<CR>

" folds
nnoremap <expr>.c foldlevel(line('.')) - (foldclosed(line('.')) > 0) > 1 ? "zXzc" : "zm"
nnoremap <expr><Space> foldclosed(line('.')) == -1 ? "<Space>" : "zv"
xnoremap <expr><Space> foldclosed(line('.')) == -1 ? "di<Space><Space><Left><Esc>p" : "<esc>zvgv"

" popup
inoremap <expr><S-Tab> pumvisible()? "<C-p>"       : "<S-Tab>"
inoremap <expr><Tab>   pumvisible()? "<C-n>"       : "<Tab>"
inoremap <expr><Up>    pumvisible()? "<C-y><Up>"   : "<Up>"
inoremap <expr><Down>  pumvisible()? "<C-y><Down>" : "<Down>"

" tags
nnoremap l <C-]>
xnoremap l <C-]>

"}}}

" terminal {{{
if executable('urxvtc')
  nnoremap .ö  :call system('urxvtc')<CR>
  nnoremap ..ö :call system('urxvtc -cd '.expand('%:p:h').' -e zsh')<CR>
endif
" }}}

" plugins {{{

" ale
nnoremap <expr>..a ":set signcolumn=".(g:ale_enabled?"auto":"yes")
  \ ."<CR>:".(g:ale_enabled?"ALEDisable":"ALEEnable")."<CR>"

" splitjoin
nnoremap .j :SplitjoinJoin<CR>
nnoremap .k :SplitjoinSplit<CR>

" sandwich
nmap s <Nop>
xmap s <Nop>
nmap , <Plug>(operator-sandwich-dot)

nmap .{ vi{<BS><Right>vi{<Space>
xmap .$ sa{hi$<Esc><Right>vi{
xmap .{ sa{<Left>vi{
xmap .( sa(<Left>vi(
xmap .[ sa[<Left>vi[
xmap ." sa"<Left>vi"
xmap .' sa'<Left>vi'
xmap .` sa`<Left>vi`

" switch
nmap <silent>ss :Switch<CR>

" exchange
nmap x cx
xmap x X

" emmet
nmap <S-Space> <Plug>(emmet-expand-abbr)
vmap <S-Space> <Plug>(emmet-expand-abbr)
imap <S-Space> <Plug>(emmet-expand-abbr)
nmap <C-y>,    <Plug>(emmet-expand-abbr)
vmap <C-y>,    <Plug>(emmet-expand-abbr)
imap <C-y>,    <Plug>(emmet-expand-abbr)

" neosnippet
if has('nvim')
  imap <C-n> <Plug>(neosnippet_expand_or_jump)
  xmap <C-n> <Plug>(neosnippet_expand_target)
endif

" gitgutter
nmap hn <Plug>(GitGutterNextHunk)
nmap hp <Plug>(GitGutterPrevHunk)
nmap hs <Plug>(GitGutterStageHunk)
nmap hd <Plug>(GitGutterUndoHunk)
nmap hv <Plug>(GitGutterPreviewHunk)

" quickfix
nmap gn <Plug>(qf_qf_next)
nmap gp <Plug>(qf_qf_previous)

" loclist
nmap gN <Plug>(qf_loc_next)
nmap gP <Plug>(qf_loc_previous)

" projectionist
nnoremap SS :A<cr>

" }}}

" custom bs behavior {{{
xnoremap <silent><BS> "rd:let @r = substitute(@r, '^\s\+\\|\s\+$', '', 'g')<cr>"rP
imap <expr><BS> BS()
function! BS()
  "> | < to >|<
  if strpart(getline('.'), col('.')-3, 4) == '>  <'
    return "\<BS>\<Del>"
  endif
  ">\r|\r< to >|<
  let nchar = getline(line('.')-1)[-1:]
  let schar = matchstr(getline(line('.')+1), '^\s*\zs\S')
  let isEmpty = empty(getline('.'))
  if isEmpty && ( '>' == nchar) && ('<' == schar)
    return "\<BS>".repeat("\<Del>", len(matchstr(getline(line('.') + 1), '^\s*\S')))
  endif
  " normal or delimitMateBS
  return "\<Plug>delimitMateBS"
endfunction
" }}}

" custom del behavior {{{
nmap <Del> i<Del><Esc><Right>
imap <expr><Del> Del()
function! Del()
  " <a>|</a> to <a/>|
  let cpos = [line('.'), col('.')]
  if strpart(getline('.'), cpos[1]-2, 3) == '></'
    let tagname = GetTag()
    let tpos = MatchTag(tagname, 0)
    if cpos[0] == tpos[0]
      call cursor(tpos[0], tpos[1])
      let tpos = MatchTag(tagname, 1)
      if cpos[0] == tpos[0] && cpos[1] == tpos[1]
        return repeat("\<Del>", strlen(tagname) + 3)."\<Left>/\<Right>"
      endif
    endif
  endif
  " noram del
  return "\<Del>"
endfunction
" }}}

" custom space behavior {{{
inoremap <Plug>double_space <Space><Space>
inoremap <C-Space> <Space>
imap <expr><Space> Space()
function! Space()
  " open fold when above fold
  if foldclosed(line('.')) != -1
    return "\<C-o>zo"
  endif
  " expand snippet when avilable
  if has('nvim') && neosnippet#expandable()
    return "\<Plug>(neosnippet_expand)"
  endif
  " create close tag
  if getline('.')[col('.') - 2] == '>'
    let tagname = GetTag()
    if tagname != '' && tagname[0] != '/'
      let tpos = MatchTag(tagname, 0)
      call cursor(tpos[0], tpos[1])
      if MatchTag(tagname, 1) == [0, 0]
        return '</'.tagname.'>'.repeat("\<Left>", strlen(tagname)+3)
      endif
    endif
    if getline('.')[col('.') - 1] == '<'
      return "\<Plug>double_space\<Left>"
    endif
  endif
  " normal or delimitMateSpace
  return "\<Plug>delimitMateSpace"
endfunction
" }}}

" custom cr behavior {{{

" newline like o<esc>
nmap <expr><CR> foldclosed(line('.')) == -1 ? "i<End><CR><Esc>" : "o<Esc>"

" ...[selection]... to ...\r[selection]\r..
xnoremap <silent><CR> "rdi<Space><Esc>""diwa<Left><CR><CR><Esc>==<Up>"rp=']zo

inoremap <Plug>split_lines <CR><CR><UP><Tab>
imap <expr><CR> Return()
function! Return()
  "<a>| to <a>\r|\r</a>
  let line = getline(line("."))
  let col = col(".")
  if getline('.')[col('.') - 2] == '>'
    let tagname = GetTag()
    if tagname != '' && tagname[0] != '/'
      let tpos = MatchTag(tagname, 0)
      call cursor(tpos[0], tpos[1])
      if MatchTag(tagname, 1) == [0, 0]
        return '</'.tagname.'>'.repeat("\<Left>", strlen(tagname)+3)."\<Plug>split_lines"
      endif
    endif
    ">|< to >\r|\r<
    if getline('.')[col('.') - 1] == '<'
      return "\<Plug>split_lines"
    endif
  endif
  " endtag and delimitMateCR
  return "\<Plug>delimitMateCR\<Plug>DiscretionaryEnd"
endfunction

" disable custom behavior in qf and cmd window
augroup remapCr
  autocmd!
  autocmd CmdwinEnter * nnoremap <buffer><CR> <CR>
  autocmd FileType   qf nnoremap <buffer><CR> <CR>
augroup END

" }}}

" tag matching helper functions {{{
function! GetTag()
  let c_col  = col('.') - 2
  let matched = matchstr(getline('.'), '\(<[^<>]*\%'.c_col.'c.\{-}>\)\|\(\%'.c_col.'c<.\{-}>\)')
  if matched =~ '/>$'
    return ""
  elseif matched == ""
    " The tag itself may be spread over multiple lines.
    let matched = matchstr(getline('.'), '\(<[^<>]*\%'.c_col.'c.\{-}$\)\|\(\%'.c_col.'c<.\{-}$\)')
    if matched == ""
      return ""
    endif
  endif

  return matchstr(matched, '<\zs/\?\%([[:alpha:]_:]\|[^\x00-\x7F]\)\%([-._:[:alnum:]]\|[^\x00-\x7F]\)*')
endfunction

function! MatchTag(tagname, forwards)
  "returns the position of a matching tag or [0 0]

  let starttag = '\V<'.escape(a:tagname, '\').'\%(\_s\%(\.\{-}\|\_.\{-}\%<'.line('.').'l\)/\@<!\)\?>'
  let midtag = ''
  let endtag = '\V</'.escape(a:tagname, '\').'\_s\*'.(a:forwards?'':'\zs').'>'
  let flags = 'nW'.(a:forwards?'':'b')

  " When not in a string or comment ignore matches inside them.
  let skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
        \ '=~?  "\\%(html\\|xml\\)String\\|\\%(html\\|xml\\)CommentPart"'
  execute 'if' skip '| let skip = 0 | endif'

  return searchpairpos(starttag, midtag, endtag, flags, skip)
endfunction
" }}}
