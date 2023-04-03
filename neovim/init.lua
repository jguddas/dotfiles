-- " vim:fdm=marker
vim.opt.runtimepath:remove(vim.fn.expand("/usr/share/vim/vimfiles"))

vim.cmd([[
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  set grepprg=ag\ --vimgrep\ --ignore=\"**.min.js\"\ --ignore-case
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

augroup interface
  autocmd!
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd VimResized,WinNew * wincmd =
  autocmd WinEnter * setlocal winwidth=80 | wincmd =
  autocmd WinLeave * setlocal winwidth=20
  autocmd CmdlineEnter / setlocal nofoldenable
  autocmd CmdlineLeave / setlocal foldenable | normal zv
augroup END

augroup clipboard
  autocmd!
  autocmd TextYankPost *
    \  if v:event.regname==''&&v:event.operator=='y'
    \|   let @+=join(v:event.regcontents, "\n")
    \| endif
augroup END

" persistent undo
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

" custom fold
function! CustomFoldText()
  return getline(v:foldstart) . ' '
endfunction
set foldtext=CustomFoldText()

" auto matically create parent directory
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END
]])

-- Options {{{
vim.opt.autoread = true
vim.opt.background = "light"
vim.opt.backspace = "indent,eol,start"
vim.opt.colorcolumn = "80"
vim.opt.diffopt = "foldcolumn:0,filler"
vim.opt.equalalways = true
vim.opt.expandtab = true
vim.opt.fillchars = { vert = "┃", fold = "·", diff = " " }
vim.opt.foldmethod = "syntax"
vim.opt.foldnestmax = 2
vim.opt.formatoptions:remove({ "-t" })
vim.opt.hidden = true
vim.opt.history = 1000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 2
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = "trail:·,tab:· "
vim.opt.mouse = "a"
vim.opt.backup = false
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.numberwidth = 1
vim.opt.path = ".,**"
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 2
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg"
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.updatetime = 500
vim.opt.wildmenu = true
vim.opt.inccommand = "split"
-- }}}

---- Plugins ---- {{{
local Plug = vim.fn["plug#"]
vim.call("plug#begin", vim.fn.stdpath("config") .. '/plugged')
Plug("lewis6991/impatient.nvim", { ["branch"] = "main" })
Plug("nvim-lua/plenary.nvim")

-- interface
Plug("itchyny/lightline.vim") -- statusline plugin
Plug("pappasam/papercolor-theme-slim") -- paper color thmee
Plug("mgee/lightline-bufferline") -- lightline bufferline
Plug("mhinz/vim-sayonara") -- better buffer closing
Plug("nelstrom/vim-markdown-folding") -- better markdown folding
Plug("airblade/vim-gitgutter") -- git diff column
Plug("romainl/vim-qf") -- better quickfix mappings

-- syntax
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

-- completion
Plug("tpope/vim-sleuth") -- adjusts shiftwidth and expandtab

Plug("L3MON4D3/LuaSnip") -- snippets
Plug("saadparwaiz1/cmp_luasnip")

Plug("neovim/nvim-lspconfig") -- lsp
Plug("hrsh7th/cmp-nvim-lsp")
Plug("williamboman/mason.nvim")
Plug("williamboman/mason-lspconfig.nvim", { ["branch"] = "main" })
Plug("neovim/nvim-lspconfig")

Plug("jose-elias-alvarez/null-ls.nvim", { ["branch"] = "main" }) -- linting
Plug("jay-babu/mason-null-ls.nvim", { ["branch"] = "main" })
Plug("lukas-reineke/lsp-format.nvim")

Plug("hrsh7th/cmp-buffer", { ["branch"] = "main" })
Plug("hrsh7th/cmp-path", { ["branch"] = "main" })
Plug("hrsh7th/cmp-cmdline", { ["branch"] = "main" })
Plug("hrsh7th/nvim-cmp", { ["branch"] = "main" }) -- completion
Plug("zbirenbaum/copilot.lua") -- copilot

Plug("windwp/nvim-autopairs", { commit = "4fc96c8f3df89b6d23e5092d31c866c53a346347" })
Plug("jguddas/nvim-ts-autotag", { ["branch"] = "main" })
Plug("RRethy/nvim-treesitter-endwise")

-- actions
Plug("AndrewRadev/splitjoin.vim") -- join and split lines intelligently
Plug("AndrewRadev/switch.vim", { ["on"] = "Switch" }) -- switch segments of text
Plug("machakann/vim-sandwich") -- surround objects
Plug("machakann/vim-swap") -- reorder delimited items
Plug("tommcdo/vim-exchange") -- exchange objects
Plug("tomtom/tcomment_vim") -- smart comments
Plug("wellle/targets.vim") -- additional text objects
Plug("tpope/vim-abolish")
Plug("schickling/vim-bufonly")
Plug("junegunn/vim-easy-align")

-- integration
Plug("sickill/vim-pasta") -- pasting with indentation
Plug("editorconfig/editorconfig-vim") -- load .editorconfig
Plug("justinmk/vim-dirvish") -- filebrowser
Plug("tpope/vim-eunuch") -- UNIX shell commands
Plug("tpope/vim-fugitive") -- git wrapper
Plug("tpope/vim-rhubarb") -- fugitive github support

vim.call("plug#end")
require("impatient")
-- }}}

---- Plugin Settings ---- {{{
vim.cmd("source" .. vim.fn.stdpath("config") .. "/plugins.config.vim")

-- Colorscheme {{{
vim.cmd("colorscheme PaperColorSlim")
vim.cmd([[
highlight Search                     guifg=#444444 guibg=#ffff5f gui=none
highlight Folded                     guifg=#0087af guibg=#afd7ff gui=none
highlight Comment                    guifg=#878787 guibg=none    gui=none
highlight NonText                    guifg=#bcbcbc guibg=#eeeeee gui=none
highlight SpecialKey                 guifg=#bcbcbc guibg=#eeeeee gui=none
highlight EndOfBuffer                guifg=#bcbcbc guibg=#eeeeee gui=none
highlight NormalFloat                guifg=#444444 guibg=#eeeeee gui=none
highlight FloatBorder                guifg=#bcbcbc guibg=#eeeeee gui=bold
highlight DiagnosticUnderlineError   guifg=#444444 guibg=#ffafd7 gui=none
highlight DiagnosticUnderlineWarn    guifg=#444444 guibg=#ffffaf gui=none
highlight DiagnosticUnderlineInfo    guifg=#444444 guibg=#afff87 gui=none
highlight DiagnosticUnderlineHint    guifg=#444444 guibg=#d7d7ff gui=none
highlight DiagnosticSignError        guifg=#af0000 guibg=#ffd7ff gui=none
highlight DiagnosticSignWarn         guifg=#af5f00 guibg=none    gui=none
highlight DiagnosticSignInfo         guifg=#00af5f guibg=none    gui=none
highlight DiagnosticSignHint         guifg=#bcbcbc guibg=none    gui=none
highlight DiagnosticVirtualTextError guifg=#af0000 guibg=#ffd7ff gui=bold
highlight DiagnosticVirtualTextWarn  guifg=#af5f00 guibg=#ffffaf gui=bold
highlight DiagnosticVirtualTextInfo  guifg=#00af5f guibg=#afffaf gui=bold
highlight DiagnosticVirtualTextHint  guifg=#0087af guibg=#afd7ff gui=bold
highlight DiagnosticFloatingError    guifg=#af0000 guibg=none    gui=bold
highlight DiagnosticFloatingWarn     guifg=#af5f00 guibg=none    gui=bold
highlight DiagnosticFloatingInfo     guifg=#00af5f guibg=none    gui=bold
highlight DiagnosticFloatingHint     guifg=#0087af guibg=none    gui=bold

sign define DiagnosticSignError text= » texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn  text= ‼ texthl=DiagnosticSignWarn  linehl= numhl=
sign define DiagnosticSignInfo  text= • texthl=DiagnosticSignInfo  linehl= numhl=
sign define DiagnosticSignHint  text= • texthl=DiagnosticSignHint  linehl= numhl=
]])
-- }}}

-- Treesitter {{{
-- require("nvim-treesitter.configs").setup({
-- 	ensure_installed = {
-- 		"bash",
-- 		"c",
-- 		"css",
-- 		"html",
-- 		"java",
-- 		"javascript",
-- 		"json",
-- 		"lua",
-- 		"markdown",
-- 		"markdown_inline",
-- 		"python",
-- 		"rust",
-- 		"tsx",
-- 		"typescript",
-- 		"yaml",
-- 	},
-- 	ignore_install = { "phpdoc" },
-- 	highlight = { enable = true },
-- 	autopairs = { enable = true },
-- 	autotag = { enable = true, enable_close = false },
-- 	endwise = { enable = true },
-- 	indent = { enable = true, disable = { "python", "css" } },
-- })
--- }}}

-- Smartpairs {{{
require("nvim-ts-autotag.internal").setup({ enable_close = false })
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
local utils = require("nvim-autopairs.utils")
npairs.setup({ map_cr = false, map_bs = false })
--- }}}

-- }}}

---- Keybindings ---- {{{
vim.g.mapleader = "."
vim.keymap.set("n", ".", "<nop>")
vim.keymap.set("n", ",", ".")

-- dev
vim.keymap.set("n", "<leader><leader>s", ":source %<CR>")

-- other
vim.keymap.set("n", "U", "<C-r>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("x", "Y", "y$")
vim.keymap.set("n", "j", ":keeppatterns s/\\n\\s*/<cr>")
vim.keymap.set("x", "j", "<esc>:keeppatterns '<,'>-s/\\n\\s*/<cr>")
vim.keymap.set("n", "<home>", "g<home>")
vim.keymap.set("n", "<end>", "g<end>")
vim.keymap.set("n", "<down>", "gj")
vim.keymap.set("n", "<up>", "gk")
vim.keymap.set("v", "<c-a>", ":s/\\%V\\d\\+\\%V/\\=(submatch(0)+1)/g<cr>")
vim.keymap.set("v", "<c-x>", ":s/\\%V\\d\\+\\%V/\\=(submatch(0)-1)/g<cr>")

-- write/edit/quit/read {{{
vim.keymap.set("n", "<leader><leader>q", ":qa!<CR>")
vim.keymap.set("n", "<leader>w", ":write!<CR>")
vim.keymap.set("n", "<leader>x", ":w<CR>:Sayonara!<CR>")
vim.keymap.set("n", "<C-r>", ":checktime<CR>")
vim.keymap.set("n", "<leader>ä", '":edit ".expand(\'%:h\')."/"', { expr = true })
-- }}}

-- search {{{
vim.keymap.set("n", "<leader>m", ":%s///g<Left><Left>")
vim.keymap.set("n", "<leader>l", ":nohlsearch<CR>")
vim.keymap.set("n", "\\", ':grep ""<Left>')
vim.keymap.set("v", "\\", '"aygv:grep "<c-r>""<Left>')
vim.keymap.set("x", "<leader>m", ":s///g<Left><Left>")
-- }}}

-- paste {{{
vim.keymap.set("n", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>P", '"+P')
vim.keymap.set("x", "<leader>p", '"+p')
vim.keymap.set("x", "<leader>P", '"+P')
-- }}}

-- wildmenu
vim.keymap.set("c", "<Left>", "<Space><BS><Left>")
vim.keymap.set("c", "<Right>", "<Space><BS><Right>")
vim.api.nvim_set_keymap("c", "<Up>", 'pumvisible() ? "<C-p>" : "<Up>"', { expr = true })
vim.api.nvim_set_keymap("c", "<Down>", 'pumvisible() ? "<C-n>" : "<Down>"', { expr = true })

-- buffers
vim.keymap.set("n", "<leader><leader>d", ":Sayonara!<CR><C-w>c")
vim.keymap.set("n", "<leader>d", ":Sayonara!<CR>")
vim.keymap.set("n", "<leader>n", ":enew<CR>")

-- buffers
vim.keymap.set("n", "<C-n>", ":bnext<CR>")
vim.keymap.set("n", "<C-p>", ":bprev<CR>")

-- window
vim.keymap.set("n", "<leader>q", "<C-w>c")
vim.keymap.set("n", "<leader>o", ":only<CR>")
vim.keymap.set("n", "<leade><leader>o", ":BufOnly<CR>")

-- focus
vim.keymap.set("n", "<leader>u", "<C-w><Up>")
vim.keymap.set("n", "<leader>i", "<C-w><Down>")
vim.keymap.set("n", "<leader>t", "<C-w><Left>")
vim.keymap.set("n", "<leader>e", "<C-w><Right>")

-- move
vim.keymap.set("n", "<leader>U", "<C-w>K")
vim.keymap.set("n", "<leader>I", "<C-w>J")
vim.keymap.set("n", "<leader>T", "<C-w>H")
vim.keymap.set("n", "<leader>E", "<C-w>L")

-- split
vim.keymap.set("n", "<leader>v", ":vsplit<CR>")
vim.keymap.set("n", "<leader>h", ":split<CR>")

-- folds
vim.keymap.set(
	"n",
	"<leader>c",
	"foldlevel(line('.')) - (foldclosed(line('.')) > 0) > 1 ? \"zXzc\" : \"zm\"",
	{ expr = true }
)

-- quickfix
vim.keymap.set("n", "gn", "<Plug>(qf_qf_next)", { remap = true })
vim.keymap.set("n", "gp", "<Plug>(qf_qf_previous)", { remap = true })

-- lsp
vim.keymap.set("n", ".a", vim.lsp.buf.code_action, { noremap = true, silent = true })
vim.keymap.set("n", "l", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "k", vim.lsp.buf.hover, { noremap = true, silent = true })
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { focusable = false, border = "single" })

vim.cmd([[
" splitjoin
nnoremap .j :SplitjoinJoin<CR>
nnoremap .k :SplitjoinSplit<CR>

" sandwich
nmap s <Nop>
xmap s <Nop>
nmap , <Plug>(operator-sandwich-dot)

" switch
nmap <silent>ss :Switch<CR>

" exchange
nmap x cx
xmap x X

" gitgutter
nnoremap ha :G add %:p<cr>
nnoremap hr :G reset %:p<cr>
nmap hn <Plug>(GitGutterNextHunk)
nmap hp <Plug>(GitGutterPrevHunk)
nmap hs <Plug>(GitGutterStageHunk)
nmap hd <Plug>(GitGutterUndoHunk)
nmap hv <Plug>(GitGutterPreviewHunk)

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
]])

-- Space {{{
vim.keymap.set("n", "<Space>", 'foldclosed(line(\'.\')) == -1 ? "<Space>" : "zv"', { expr = true })
vim.keymap.set(
	"x",
	"<Space>",
	'foldclosed(line(\'.\')) == -1 ? "sa<Space>" : "<esc>zvgv"',
	{ expr = true, remap = true }
)
vim.keymap.set("i", "<c-space>", "<space>")
vim.keymap.set("i", "<space>", function()
	if vim.fn.foldclosed(".") > -1 then
		return "<C-o>zo"
	end

	local colnr = vim.fn.col(".")
	local line = vim.fn.getline(".")
	if line:sub(colnr - 1, colnr - 1) == ">" then
		return '<C-c>:lua if not require"nvim-ts-autotag.internal".close_tag() then vim.cmd"normal! a " end <cr>a'
	end

	if vim.tbl_contains({ "()", "[]", "{}" }, line:sub(colnr - 1, colnr)) then
		return "<space><space><left>"
	end

	return "<space>"
end, { expr = true, silent = true, noremap = true })

npairs.add_rules({
	Rule(" ", " ")
		:use_regex(true)
		:with_pair(cond.none())
		:with_move(cond.none())
		:replace_map_cr(function()
			return "<bs><del><C-g>u<CR><C-c>O"
		end)
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local context = opts.line:sub(col - 1, col + 2)
			return vim.tbl_contains({ "{  }", "(  )", "[  ]" }, context)
		end),
})
--- }}}

-- Return {{{
vim.keymap.set("x", "<cr>", "sa<cr>", { remap = true })
vim.keymap.set("n", "<cr>", function()
	if vim.bo.buftype == "" then
		return "o<esc>"
	end
	return "<cr>"
end, { expr = true, silent = true, noremap = true })
vim.keymap.set("i", "<c-cr>", "<cr>")
vim.api.nvim_set_keymap("i", "<Plug>autopairs_cr", "v:lua.MPairs.autopairs_cr()", {
	expr = true,
	noremap = true,
})
vim.keymap.set("i", "<cr>", function()
	if vim.fn.foldclosed(".") > -1 then
		return "<C-o>zo"
	end

	local colnr = vim.fn.col(".")
	local line = vim.fn.getline(".")
	if vim.tbl_contains({ "()", "[]", "{}", "<>", "><" }, line:sub(colnr - 1, colnr)) then
		return "<c-cr><esc>====O"
	end

	return "<cr>"
end, { expr = true, silent = true, noremap = true })
-- }}}

-- Backspace {{{
vim.keymap.set("n", "<BS>", "X")
vim.keymap.set("x", "<bs>", "\"rd:let @r = substitute(@r, '^\\s\\+\\|\\s\\+$', '', 'g')<cr>\"rP")
vim.keymap.set("i", "<c-bs>", "<bs>")
vim.api.nvim_set_keymap("i", "<Plug>autopairs_bs", "v:lua.MPairs.autopairs_bs()", {
	expr = true,
	noremap = true,
})
vim.keymap.set("i", "<bs>", function()
	if vim.fn.foldclosed(".") > -1 then
		return "<C-o>zo"
	end

	local colnr = vim.fn.col(".")
	local line = vim.fn.getline(".")
	if vim.tbl_contains({ "(  )", "[  ]", "{  }", ">  <" }, line:sub(colnr - 2, colnr + 1)) then
		return "<Plug>autopairs_bs"
	end
	if line:sub(colnr - 1, colnr) == "  " then
		return "<bs>"
	end

	return "<Plug>autopairs_bs"
end, { expr = true, silent = true, noremap = true })
-- }}}

-- Delete {{{
vim.keymap.set("i", "<c-del>", "<del>")
vim.keymap.set("i", "<del>", function()
	if vim.fn.foldclosed(".") > -1 then
		return "<C-o>zo"
	end

	return "<del>"
end, { expr = true, silent = true, noremap = true })
-- }}}

-- }}}

-- Completion {{{
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local luasnip = require("luasnip")
cmp.setup({
	window = {
		completion = cmp.config.window.bordered({ border = "single" }),
		documentation = cmp.config.window.bordered({ border = "single" }),
	},
	experimental = { ghost_text = true },
	completion = { completeopt = "menu,menuone,noinsert" },
	mapping = cmp.mapping.preset.insert({
		["<space>"] = cmp.mapping(function(fallback)
			if cmp.visible() and luasnip.expandable() then
				luasnip.expand()
			else
				fallback()
			end
		end),
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm()
			else
				fallback()
			end
		end),
	}),
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	sources = cmp.config.sources({
		{ name = "luasnip", priority = 1000 },
		{ name = "nvim_lsp" },
	}, {
		{ name = "path" },
		{ name = "buffer" },
	}),
})
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
require("copilot").setup({
	suggestion = {
		enabled = true,
		auto_trigger = true,
		keymap = { accept = "<tab>" },
	},
	panel = { enabled = false },
})
cmp.event:on("menu_opened", function()
	vim.b.copilot_suggestion_hidden = true
end)
cmp.event:on("menu_closed", function()
	vim.b.copilot_suggestion_hidden = false
end)
-- }}}

-- LSP {{{
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"bashls",
		"cssls",
		"html",
		"jsonls",
		"tsserver",
		"yamlls",
	},
	automatic_installation = true,
})
require("mason-lspconfig").setup_handlers({
	function(server_name) -- default handler (optional)
		require("lspconfig")[server_name].setup({})
	end,
})
vim.diagnostic.config({ virtual_text = false })
require("cmp_nvim_lsp").default_capabilities()
vim.diagnostic.config({
	float = { border = "single" },
})
vim.cmd([[
autocmd CursorHold * silent! lua vim.diagnostic.open_float({ scope = "line", focus = false })
]])
-- }}}

-- Snippets {{{
local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local func = luasnip.function_node
local choice = luasnip.choice_node
local dynamicn = luasnip.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local util = require("luasnip.util.util")

local function array_helper()
	local line = util.get_current_line_to_cursor()
	local match = string.match(line, "(%w+)s([^)]*])$")
	if match ~= nil then
		return match.gsub(match, "ie$", "y")
	end
	match = string.match(line, "(%w+)s$")
	if match ~= nil then
		return string.gsub(match, "ie$", "y")
	end
	return "val"
end

local function array_snip(method)
	luasnip.add_snippets("javascript/typescript", {
		snip(
			{ trig = "." .. method, wordTrig = false },
			{ text("." .. method .. "("), func(array_helper, {}), text(" => "), insert(0), text(")") }
		),
		snip(
			{ trig = "." .. method .. "i", wordTrig = false },
			{ text("." .. method .. "(("), func(array_helper, {}), text(", idx) => "), insert(0), text(")") }
		),
		snip(
			{ trig = "." .. method .. "a", wordTrig = false },
			{ text("." .. method .. "(("), func(array_helper, {}), text(", idx, arr) => "), insert(0), text(")") }
		),
	})
end

array_snip("every")
array_snip("filter")
array_snip("find")
array_snip("findIndex")
array_snip("flatMap")
array_snip("forEach")
array_snip("map")
array_snip("some")
luasnip.add_snippets("javascript/typescript", {
	snip(
		{ trig = ".reduce", wordTrig = false },
		{ text(".reduce(acc, "), func(array_helper, {}), text(" => "), insert(0), text(", {})") }
	),
	snip(
		{ trig = ".reducei", wordTrig = false },
		{ text(".reduce((acc, "), func(array_helper, {}), text(", idx) => "), insert(0), text(", {})") }
	),
	snip(
		{ trig = ".reducea", wordTrig = false },
		{ text(".reduce((acc, "), func(array_helper, {}), text(", idx, arr) => "), insert(0), text(", {})") }
	),
	snip(
		{ trig = ".reduceRight", wordTrig = false },
		{ text(".reduce(acc, "), func(array_helper, {}), text(" => "), insert(0), text(", {})") }
	),
	snip(
		{ trig = ".reduceRighti", wordTrig = false },
		{ text(".reduce((acc, "), func(array_helper, {}), text(", idx) => "), insert(0), text(", {})") }
	),
	snip(
		{ trig = ".reduceRighta", wordTrig = false },
		{ text(".reduce((acc, "), func(array_helper, {}), text(", idx, arr) => "), insert(0), text(", {})") }
	),
	snip({ trig = ".sort", wordTrig = false }, { text(".slice().sort((a, b) => "), insert(0), text(")") }),
	snip({ trig = ".reverse", wordTrig = false }, { text(".slice().reverse()"), insert(0), text(")") }),
	snip(
		{ trig = ".group", wordTrig = false },
		fmt(
			[[.reduce((groups, {4}) => {1}
	const key = {3}
	groups[key] = [...groups[key], val]
	return groups
{2}, {1}{2})]],
			{
				text("{"),
				text("}"),
				insert(0),
				func(array_helper, {}),
			}
		)
	),
})

luasnip.add_snippets(nil, {
	["all"] = {
		snip({ trig = "#!bash" }, { text({ "#!/usr/bin/env bash" }), insert(0) }, {
			show_condition = function(s)
				return s:sub(1, 2) == "#!"
			end,
		}),
	},
	["typescript"] = {
		snip("exi", { text("export interface ") }),
		snip("ext", { text("export type ") }),
	},
	["javascript/typescript"] = {
		snip("exc", { text("export const ") }),
		snip("exd", { text("export default ") }),
		snip("exf", { text("export function ") }),
		snip("log", { text("console.log("), insert(0), text(")") }),
		snip("logj", { text("console.log(JSON.stringify("), insert(0), text(", null, 2))") }),
	},
})
luasnip.filetype_extend("javascript", { "javascript/typescript" })
luasnip.filetype_extend("typescript", { "javascript/typescript" })
luasnip.filetype_extend("typescriptreact", { "javascript/typescript", "typescript" })

-- }}}

-- Linting {{{
require("mason-null-ls").setup({
	automatic_setup = true,
	-- ensure_installed = {
	-- 	"prettierd",
	-- 	"eslint_d",
	-- 	"stylua",
	-- 	"shellcheck",
	-- 	"cspell",
	-- },
})
require("lsp-format").setup({})
local null_ls = require("null-ls")
require("mason-null-ls").setup_handlers({
	function(source_name, methods)
		require("mason-null-ls.automatic_setup")(source_name, methods)
	end,
	cspell = function(source_name, methods)
		for i = 1, #methods do
			null_ls.register(null_ls.builtins[methods[i]][source_name].with({
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = vim.diagnostic.severity["WARN"]
				end,
			}))
		end
	end,
})
null_ls.setup({
	on_attach = function(client, bufnr)
		require("lsp-format").on_attach(client)
	end,
})
-- }}}
