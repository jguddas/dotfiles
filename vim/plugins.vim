if has('nvim') | set runtimepath^=~/.vim,~/.vim/after | endif
call plug#begin('~/.vim/bundle')

" interface
Plug 'ap/vim-css-color'              " preview colors inline
Plug 'itchyny/lightline.vim'         " statusline plugin
Plug 'jguddas/onecustom.vim'         " my colortheme
Plug 'jguddas/papercolor-theme'      " paper color thmee
Plug 'mgee/lightline-bufferline'     " lightline bufferline
Plug 'mhinz/vim-sayonara'            " better buffer closing
Plug 'nelstrom/vim-markdown-folding' " better markdown folding
Plug 'airblade/vim-gitgutter'        " git diff column
Plug 'mbbill/undotree', { 'on': 'UndotreeShow' }
Plug 'romainl/vim-qf'                " better quickfix mappings

" syntax
Plug 'cakebaker/scss-syntax.vim'     " sass
Plug 'hail2u/vim-css3-syntax'        " css
Plug 'pangloss/vim-javascript'       " javascript
Plug 'leafgarland/typescript-vim'    " typescript
Plug 'MaxMEllon/vim-jsx-pretty'      " jsx
Plug 'digitaltoad/vim-jade'          " pug
Plug 'jxnblk/vim-mdx-js'             " mdx

" completion
Plug 'Raimondi/delimitMate'          " auto-completion for quotes, parens, etc.
Plug 'sickill/vim-pasta'             " pasting with indentation
Plug 'tpope/vim-endwise'             " wisely add end
Plug 'tpope/vim-sleuth'              " adjusts shiftwidth and expandtab
Plug 'vim-scripts/closetag.vim'      " close xml tags
if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " completion
  Plug 'Shougo/neosnippet'           " snippets
endif

" actions
Plug 'AndrewRadev/splitjoin.vim'     " join and split lines intelligently
Plug 'AndrewRadev/switch.vim', { 'on': 'Switch' } " switch segments of text
Plug 'machakann/vim-sandwich'        " surround objects
Plug 'machakann/vim-swap'            " reorder delimited items
Plug 'tommcdo/vim-exchange'          " exchange objects
Plug 'tomtom/tcomment_vim'           " smart comments
Plug 'wellle/targets.vim'            " additional text objects
Plug 'tpope/vim-abolish'
Plug 'schickling/vim-bufonly'

" integration
Plug 'editorconfig/editorconfig-vim' " load .editorconfig
Plug 'tpope/vim-projectionist'       " load .projections.json
Plug 'justinmk/vim-dirvish'          " filebrowser
Plug 'tpope/vim-eunuch'              " UNIX shell commands
Plug 'tpope/vim-fugitive'            " git wrapper

call plug#end()
