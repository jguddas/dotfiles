" theme
colorscheme onecustom

" markdown
let g:markdown_fold_override_foldtext = 0

" javascript
let g:jst_default_subtype = "javascript"
let g:jsx_ext_required = 0

" emmet
let g:user_emmet_settings = {
\  'javascript.jsx' : { 'extends' : 'jsx' },
\  'lightscript.jsx' : { 'extends' : 'jsx' },
\}

" tcomment
let g:tcomment_mapleader_comment_anyway = "\<Nop>"
let g:tcomment_mapleader_uncomment_anyway = "\<Nop>"
autocmd VimEnter *
  \ call tcomment#type#Define('lightscript', tcomment#GetLineC('// %s')) |
  \ call tcomment#type#Define('lightscript_block', g:tcomment#block_fmt_c ) |
  \ call tcomment#type#Define('lightscript_inline', g:tcomment#inline_fmt_c)

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
\}]

autocmd FileType lightscript let b:switch_custom_definitions = [{
\  'const ': 'let ',
\  'let ': '',
\  '->' : '-/>',
\  '-/>' : '=>',
\  '=>' : '->',
\}]

autocmd FileType javascript,javascript.jsx let b:switch_custom_definitions = [{
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

" deoplete
if has('nvim')
  let g:deoplete#auto_complete_start_length = 1
  let g:deoplete#file#enable_buffer_path = 1
  " deoplete tern
  let g:deoplete#sources#ternjs#filetypes = [ 'javascript', 'lightscript' ]
  let g:deoplete#sources#ternjs#include_keywords = 1
  let g:deoplete#sources#ternjs#case_insensitive = 1
  " deoplete omni
  call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete,
      \ 'lua': ['\w+[.:]\w*', 'require\s*\(?["'']\w*'],
      \ 'css': ['\w{2}', '\w+[):;]?\s*\w*', '[@!]'],
      \ 'less': ['\w{2}', '\w+[):;]?\s*\w*', '[@!]'],
      \ 'scss': ['\w{2}', '\w+[):;]?\s*\w*', '[@!]'],
      \ 'sass': ['\w{2}', '\w+[):;]?\s*\w*', '[@!]'],
    \})
  call deoplete#custom#option('omni_patterns', {
      \ 'jsx': ['<', '</', '<[^>]*\s[[:alnum:]-]*', 'style="']
    \})
endif

" neosnippet
if has('nvim')
  let g:neosnippet#snippets_directory = '~/.vim/snippets'
  let g:neosnippet#disable_runtime_snippets = { '_' : 1 }
  let g:neosnippet#scope_aliases = {
  \ 'javascript': 'javascript,javascript.array,javascript.react',
  \ 'lightscript': 'javascript,lightscript,lightscript.array,lightscript.lodash,lightscript.react'
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
      \ exec "silent! unmap <buffer> <C-n>"
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
  \},
  \'component': {
    \'lineinfo': '%l:%v',
    \'filetype': '%{&ft}',
    \'path': '%<%{&readonly?" ":""}%f',
  \},
  \'inactive': { 'left': [['filename']], 'right': [] },
  \'active': {
    \'left': [['mode', 'spell', 'branch'], [''], ['path']],
    \'right': [['linter_errors', 'linter_warnings', 'lineinfo'], [''], ['filetype']]
  \},
  \'tabline': {
    \'left': [['buffers']],
    \'right': [['tabs']]
  \},
  \'tab': {
    \ 'active': ['tabnum'],
    \ 'inactive': ['tabnum']
  \},
  \'component_expand': {
    \'tabs': 'LightlineTabs',
    \'buffers': 'lightline#bufferline#buffers',
    \'linter_warnings': 'lightline#ale#warnings',
    \'linter_errors': 'lightline#ale#errors',
  \},
  \'component_type': {
    \'buffers': 'tabsel',
    \'tabs': 'tabsel',
    \'linter_warnings': 'warning',
    \'linter_errors': 'error',
  \},
  \'separator': { 'left': '', 'right': '' },
  \'subseparator': { 'left': '|', 'right': '|' },
  \'tabline_separator': { 'left': '', 'right': '' },
  \'tabline_subseparator': { 'left': '', 'right': '' }
\}
