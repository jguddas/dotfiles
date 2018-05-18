if has('nvim') | let &runtimepath.=',~/.vim' | endif
call plug#begin('~/.vim/bundle')

" interface
Plug 'ap/vim-css-color'              " preview colors inline
Plug 'itchyny/lightline.vim'         " statusline plugin
Plug 'jguddas/onecustom.vim'         " my colortheme
Plug 'maximbaz/lightline-ale'        " lightline ale integration
Plug 'mgee/lightline-bufferline'     " lightline bufferline
Plug 'mhinz/vim-sayonara'            " better buffer closing
Plug 'nelstrom/vim-markdown-folding' " better markdown folding

" syntax
Plug 'cakebaker/scss-syntax.vim'     " sass
Plug 'cespare/vim-toml'              " toml
Plug 'hail2u/vim-css3-syntax'        " css
Plug 'jguddas/vim-lightscript'       " lightscript
Plug 'pangloss/vim-javascript'       " javascript
Plug 'lervag/vimtex'                 " latex
Plug 'mxw/vim-jsx'                   " jsx
Plug 'wavded/vim-stylus'             " stylus

" completion
Plug 'Raimondi/delimitMate'          " auto-completion for quotes, parens, etc.
Plug 'sedm0784/vim-you-autocorrect', { 'do': ':EnableAutocorrect' }
Plug 'sickill/vim-pasta'             " pasting with indentation
Plug 'tpope/vim-abolish'             " better abbreviations
Plug 'tpope/vim-endwise'             " wisely add end
Plug 'tpope/vim-sleuth'              " adjusts shiftwidth and expandtab
Plug 'vim-scripts/closetag.vim'      " close xml tags
Plug 'mattn/emmet-vim'               " expand css like abbreviations to html
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " autocomplete
  Plug 'Shougo/neosnippet'           " snippets
  Plug 'carlitux/deoplete-ternjs'    " autocomplete javascript with ternjs
  Plug 'zchee/deoplete-zsh'          " autocomplete zsh
endif

" actions
Plug 'AndrewRadev/splitjoin.vim'     " join and split lines intelligently
Plug 'AndrewRadev/switch.vim', { 'on': 'Switch' } " switch segments of text
Plug 'godlygeek/tabular'             " align lines
Plug 'machakann/vim-sandwich'        " surround objects
Plug 'machakann/vim-swap'            " reorder delimited items
Plug 'tommcdo/vim-exchange'          " exchange objects
Plug 'tomtom/tcomment_vim'           " smart comments
Plug 'wellle/targets.vim'            " additional text objects

" integration
Plug 'editorconfig/editorconfig-vim' " load .editorconfig
Plug 'junegunn/gv.vim', { 'on': 'GV' } " git repo viwer
Plug 'justinmk/vim-dirvish'          " filebrowser
Plug 'mileszs/ack.vim'               " ack wrapper
Plug 'tpope/vim-eunuch'              " UNIX shell commands
Plug 'tpope/vim-fugitive'            " git wrapper
Plug 'w0rp/ale', { 'on': ['ALEEnable', 'ALEToggle'] } " linting engine

call plug#end()
