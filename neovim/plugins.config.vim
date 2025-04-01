" editorconfig
let g:sleuth_lua_defaults = 'tabstop=2'
let g:EditorConfig_preserve_formatoptions = 1

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

" eunuch
let g:eunuch_no_maps = 1

" tcomment
let g:tcomment_mapleader_comment_anyway = "\<Nop>"
let g:tcomment_mapleader_uncomment_anyway = "\<Nop>"

" coc
" autocmd FileType javascript setlocal filetype=javascript.jsx
" autocmd User CocOpenFloat
"   \ call setwinvar(g:coc_last_float_win, "&foldenable", 0) |
"   \ call setwinvar(g:coc_last_float_win, "&foldcolumn", 0)

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
\  'write': 'read',
\  'read': 'write',
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

autocmd FileType gitrebase let b:switch_custom_definitions = [{
\  'pick': 'edit',
\  'edit': 'fixup',
\  'fixup': 'pick',
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
  \ 'markdown.mdx': 'javascript,javascript.array,javascript.react',
  \ 'lightscript': 'javascript,lightscript,lightscript.array,lightscript.lodash,lightscript.react',
  \ 'typescript': 'javascript,javascript.array,javascript.react,typescript',
  \ 'typescriptreact': 'javascript,javascript.array,javascript.react,typescript,typescriptreact',
  \ }
endif
function! ArrayHelper(method)
  let line=getline('.')[0:col('.')-1]
  let match1=matchstr(line, '\w\+\zes'.a:method.'$')
  if match1 != ''
    return substitute(match1, 'ie$', 'y', '')
  endif
  let match2=match(line, 'keys(\w*)'.a:method.'$')
  let match3=match(line, 'entries(\w*)'.a:method.'$')
  return match2 > -1 ? 'key' : match3 > -1 ? '([ key, val ])' : 'val'
endfunction

" delimitmate
let delimitMate_expand_space = 1
let delimitMate_expand_cr = 1
au FileType markdown let b:delimitMate_nesting_quotes = ['`']

" dirvish
autocmd FileType dirvish
      \ exec "silent! unmap <buffer> <C-p>" |
      \ exec "silent! unmap <buffer> <C-n>" |
      \ exec "silent! unmap <buffer> ."
let g:dirvish_mode = ':sort r /[^\/]$/'

" ligthline
function! LightlineBranch()
  let maxlen = 40
  if &ft !~? 'vimfiler' && exists('*FugitiveHead')
    let branch = FugitiveHead()
    if len(branch) < winwidth(0) - maxlen - 15
      return branch
    endif
    let branch = pathshorten(FugitiveHead())
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
let g:lightline#colorscheme#PaperColor_light_light#palette = {
\ 'inactive': {
\   'right': [['#eeeeee','#444444',0,7],['#eeeeee','#444444',0,7]],
\   'middle': [['#444444','#bcbcbc',7,8]],
\   'left': [['#444444','#bcbcbc',7,8],['#444444','#bcbcbc',7,8]]
\ },
\ 'replace': {
\   'right': [['#eeeeee','#d70000',0,9,'bold'],['#444444','#bcbcbc',7,8]],
\   'left': [['#eeeeee','#d70000',0,9,'bold'],['#444444','#bcbcbc',7,8]]
\ },
\ 'normal': {
\   'right': [['#eeeeee','#d70087',0,10,'bold'],['#444444','#bcbcbc',7,8]],
\   'middle': [['#444444','#bcbcbc',7,8]],
\   'warning': [['#444444','#bcbcbc',7,8,'bold']],
\   'left': [['#eeeeee','#d70087',0,10,'bold'],['#444444','#bcbcbc',7,8]],
\   'error': [['#444444','#bcbcbc',7,8,'bold']]
\ },
\ 'tabline': {
\   'right': [['#444444','#bcbcbc',7,8]],
\   'middle': [['#444444','#bcbcbc',7,8]],
\   'left': [['#444444','#bcbcbc',7,8]],
\   'tabsel': [['#eeeeee','#d70087',0,10]]
\ },
\ 'visual': {
\   'right': [['#eeeeee','#d75f00',0,13,'bold'],['#444444','#bcbcbc',7,8]],
\   'left': [['#eeeeee','#d75f00',0,13,'bold'],['#444444','#bcbcbc',7,8]]
\ },
\ 'insert': {
\   'right': [['#eeeeee','#00af5f',0,12,'bold'],['#444444','#bcbcbc',7,8]],
\   'left': [['#eeeeee','#00af5f',0,12,'bold'],['#444444','#bcbcbc',7,8]]
\ }}

let g:lightline = {
  \'colorscheme': 'PaperColor_light_light',
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

" autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
