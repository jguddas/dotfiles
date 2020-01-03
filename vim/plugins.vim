if has('nvim') | set runtimepath^=~/.vim,~/.vim/after | endif
call plug#begin('~/.vim/bundle')

" interface
Plug 'ap/vim-css-color'              " preview colors inline
Plug 'itchyny/lightline.vim'         " statusline plugin
Plug 'jguddas/onecustom.vim'         " my colortheme
Plug 'mgee/lightline-bufferline'     " lightline bufferline
Plug 'mhinz/vim-sayonara'            " better buffer closing
Plug 'nelstrom/vim-markdown-folding' " better markdown folding
Plug 'airblade/vim-gitgutter'        " git diff column
Plug 'mbbill/undotree', { 'on': 'UndotreeShow' }
Plug 'romainl/vim-qf'                " better quickfix mappings

" syntax
Plug 'cakebaker/scss-syntax.vim'     " sass
Plug 'cespare/vim-toml'              " toml
Plug 'hail2u/vim-css3-syntax'        " css
Plug 'pangloss/vim-javascript'       " javascript
Plug 'HerringtonDarkholme/yats.vim'  " typescript
Plug 'lervag/vimtex'                 " latex
Plug 'MaxMEllon/vim-jsx-pretty'      " jsx
Plug 'wavded/vim-stylus'             " stylus
Plug 'digitaltoad/vim-jade'          " pug

" completion
Plug 'Raimondi/delimitMate'          " auto-completion for quotes, parens, etc.
Plug 'sedm0784/vim-you-autocorrect', { 'do': ':EnableAutocorrect' }
Plug 'sickill/vim-pasta'             " pasting with indentation
Plug 'tpope/vim-endwise'             " wisely add end
Plug 'tpope/vim-sleuth'              " adjusts shiftwidth and expandtab
Plug 'vim-scripts/closetag.vim'      " close xml tags
Plug 'mattn/emmet-vim'               " expand css like abbreviations to html
if has('nvim')
  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}} " completion
  Plug 'Shougo/neosnippet'           " snippets
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
Plug 'tpope/vim-projectionist'       " load .projections.json
Plug 'junegunn/gv.vim', { 'on': 'GV' } " git repo viwer
Plug 'justinmk/vim-dirvish'          " filebrowser
Plug 'tpope/vim-rhubarb'             " github fugitive extantion
Plug 'tpope/vim-eunuch'              " UNIX shell commands
Plug 'tpope/vim-fugitive'            " git wrapper
Plug 'w0rp/ale'                      " linting engine

call plug#end()
