" theme
colorscheme onecustom

" gitgutter
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '━'
let g:gitgutter_sign_removed_first_line = '┳'
let g:gitgutter_sign_modified_removed = '┻'
let g:gitgutter_override_sign_column_highlight = 0
autocmd TextChanged,InsertEnter,InsertLeave * GitGutter

" markdown
let g:markdown_fold_override_foldtext = 0

" emmet
let g:user_emmet_settings = {
\  'javascript' : { 'extends' : 'jsx' }
\}

" tcomment
let g:tcomment_mapleader_comment_anyway = "\<Nop>"
let g:tcomment_mapleader_uncomment_anyway = "\<Nop>"
autocmd VimEnter *
  \ call tcomment#type#Define('lightscript', tcomment#GetLineC('// %s')) |
  \ call tcomment#type#Define('lightscript_block', g:tcomment#block_fmt_c ) |
  \ call tcomment#type#Define('lightscript_inline', g:tcomment#inline_fmt_c)

" coc
autocmd FileType javascript setlocal filetype=javascript.jsx

" splitjoin
let g:splitjoin_html_attributes_bracket_on_new_line=1
autocmd FileType lightscript
  \ let b:splitjoin_split_callbacks = [
  \ 'sj#js#SplitArgs',
  \ 'sj#js#SplitArray',
  \ 'sj#js#SplitObjectLiteral',
  \ ] |
  \ let b:splitjoin_join_callbacks = [
  \ 'sj#js#JoinArray',
  \ 'sj#js#JoinArgs',
  \ 'sj#js#JoinObjectLiteral',
  \ ]

" operator sandwitch
highlight link OperatorSandwichChange IncSearch

" switch
let s:apostrophe = "'"
let g:switch_custom_definitions = [{
\  '`\([^`]*\)`' : '"\1"',
\  '"\([^"]*\)"' : s:apostrophe.'\1'.s:apostrophe,
\  s:apostrophe.'\([^'.s:apostrophe.']*\)'.s:apostrophe : '`\1`',
\}, {
\  '\<[a-z0-9]\+_\k\+\>': {
\    '_\(.\)': '\U\1'
\  },
\  '\<[a-z0-9]\+[A-Z]\k\+\>': {
\    '\([A-Z]\)': '_\l\1'
\  },
\}]

autocmd FileType lightscript let b:switch_custom_definitions = [{
\  'const ': 'let ',
\  'let ': '',
\  '->' : '-/>',
\  '-/>' : '=>',
\  '=>' : '->',
\}]

autocmd FileType javascript let b:switch_custom_definitions = [{
\  'let': 'const',
\  'const': 'let',
\  'var': 'const',
\}]

" targets
let g:targets_argOpening = '[({[]'
let g:targets_argClosing = '[]})]'
let g:targets_argSeparator = '[,;]'

" gv
autocmd FileType GV setlocal listchars=trail:\ 

" neosnippet
if has('nvim')
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
  let g:neosnippet#scope_aliases = {
  \ 'javascript': 'javascript,javascript.array,javascript.react',
  \ 'lightscript': 'javascript,lightscript,lightscript.array,lightscript.lodash,lightscript.react',
  \ 'typescript': 'javascript,javascript.array,javascript.react,typescript',
  \ 'typescriptreact': 'javascript,javascript.array,javascript.react,typescript,typescriptreact',
  \ }
endif
function! ArrayHelper(method)
  let line=getline('.')[0:col('.')-1]
  let match1=matchstr(line, '\w\+\zes'.a:method.'$')
  if match1 != ''
    return match1
  endif
  let match2=match(line, 'keys(\w*)'.a:method.'$')
  return match2 > -1 ? 'key' : 'val'
endfunction

" delimitmate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
au FileType markdown let b:delimitMate_nesting_quotes = ['`']

" ale
let g:ale_enabled = 0
let g:ale_set_signs = 1
let g:ale_sign_error = ' »'
let g:ale_sign_warning = ' ‼'
let g:ale_sign_info = ' •'
let g:ale_linters = {
  \  'lightscript': ['eslint'],
  \  'zsh': ['shellcheck'],
  \}
let g:ale_linter_aliases = { 'lightscript': 'javascript' }

" dirvish
autocmd FileType dirvish
      \ call fugitive#detect(@%) |
      \ exec "silent! unmap <buffer> <C-p>" |
      \ exec "silent! unmap <buffer> <C-n>" |
      \ exec "silent! unmap <buffer> ."
let g:dirvish_mode = ':sort r /[^\/]$/'

" ligthline
function! LightlineBranch()
  let maxlen = 40
  if &ft !~? 'vimfiler' && exists('*fugitive#head')
    let branch = fugitive#head()
    if len(branch) < winwidth(0) - maxlen - 15
      return branch
    endif
    let branch = pathshorten(fugitive#head())
    if len(branch) < winwidth(0) - maxlen
      return branch
    endif
    if winwidth(0) - 1 <= maxlen
      return ''
    endif
    return '…' . branch[(1 - (winwidth(0) - maxlen)):]
  endif
  return ''
endfunction

function! LightlineTabs()
  let [x, y, z] = [[], [], []]
  let cnt = tabpagenr('$')
  if cnt == 1
    return [x, y, z]
  endif
  return lightline#tabs()
endfunction

function! LighlineDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E:' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W:' . info['warning'])
  endif
  return join(msgs, ' | ')
endfunction

let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#read_only = ''
let g:lightline#bufferline#modified = '+'
let g:lightline#bufferline#more_buffers = '…'
let g:lightline#bufferline#filename_modifier = ':t'

let g:lightline#ale#indicator_warnings = 'W:'
let g:lightline#ale#indicator_errors = 'E:'

let g:lightline = {
  \'colorscheme': 'onecustom',
  \'component_function': {
    \'branch': 'LightlineBranch',
    \'cocstatus': 'LighlineDiagnostic',
  \},
  \'component': {
    \'lineinfo': '%l:%v',
    \'filetype': '%{&ft}',
    \'path': '%<%{&readonly?" ":""}%f',
  \},
  \'inactive': { 'left': [['filename']], 'right': [] },
  \'active': {
    \'left': [['mode', 'spell', 'branch'], [''], ['path']],
    \'right': [['cocstatus', 'lineinfo'], [''], ['filetype']]
  \},
  \'tabline': {
    \'left': [['buffers']],
    \'right': [['tabs']]
  \},
  \'tab': {
    \ 'active': ['tabnum'],
    \ 'inactive': ['tabnum'],
  \},
  \'component_expand': {
    \'tabs': 'LightlineTabs',
    \'buffers': 'lightline#bufferline#buffers',
  \},
  \'component_type': {
    \'buffers': 'tabsel',
    \'tabs': 'tabsel',
  \},
  \'separator': { 'left': '', 'right': '' },
  \'subseparator': { 'left': '|', 'right': '|' },
  \'tabline_separator': { 'left': '', 'right': '' },
  \'tabline_subseparator': { 'left': '', 'right': '' }
\}

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
