--
-- defaults
--
local opt = vim.opt
local keymap = vim.keymap
local cmd = vim.cmd
local g = vim.g

-- for nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- apperance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.number = true
opt.cursorline = true
opt.textwidth = 120

-- display
opt.relativenumber = true
opt.wrap = false
opt.hidden = true
opt.showcmd = false
opt.inccommand = "nosplit"
opt.laststatus = 2

-- mouse
-- opt.mouse:append("a")
opt.mouse = "nv"

-- split window
opt.splitright = true
opt.splitbelow = true

-- scroll
opt.scrolloff = 4
opt.sidescrolloff = 10
opt.ttyfast = true
opt.lazyredraw = false -- avoid issue in noice

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
-- opt.wildignorecase = true;

-- temp files, backup, swap, etc
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = false

-- editing
opt.autoread = true -- auto read if file is modified in other place
opt.title = true
opt.wildmenu = true
opt.errorbells = false
opt.spell = false
opt.history = 1000

-- match bracket
opt.showmatch = true
opt.matchtime = 2

-- fold
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevel = 99
opt.foldlevelstart = 99

-- indentation
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- filetype spec
cmd([[autocmd FileType lua,jsom,yaml setlocal ts=2 sts=2 sw=2]])
cmd([[autocmd FileType json set formatprg=jq]])
cmd([[autocmd BufNewFile,BufRead *.typst set filetype=typst]])
cmd([[autocmd BufNewFile,BufRead *.typ set filetype=typst]])

--
-- keymaps
--

g.mapleader = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
g.localmapleader = ","

keymap.set("n", "<esc>", ":nohl<CR>")
keymap.set("n", "Q", "<nop>")
keymap.set("n", "<c-q>", "<nop>")

-- buffer
keymap.set("n", "[b", ":bprevious<CR>")
keymap.set("n", "]b", ":bnext<CR>")

-- clipboard
keymap.set("v", "Y", '"+y')

-- filetype
-- keymap.set("n", "<leader>ft", ":set ft=")

-- command mode and insert mode emacs-style {
keymap.set("c", "<c-b>", "<left>")
keymap.set("c", "<c-f>", "<right>")
keymap.set("c", "<c-n>", "<down>")
keymap.set("c", "<c-p>", "<up>")
keymap.set("c", "<c-a>", "<home>")
keymap.set("c", "<c-e>", "<end>")
keymap.set("c", "<c-d>", "<del>")
keymap.set("c", "<m-b>", "<s-left>")
keymap.set("c", "<m-f>", "<s-right>")

keymap.set("i", "<c-b>", "<left>")
keymap.set("i", "<c-f>", "<right>")
keymap.set("i", "<c-a>", "<home>")
keymap.set("i", "<c-e>", "<end>")
keymap.set("i", "<c-d>", "<del>")
keymap.set("i", "<c-k>", "<esc>lC")
keymap.set("i", "jk", "<esc>")

-- faster scroll
keymap.set("n", "<c-e>", "2<c-e>")
keymap.set("n", "<c-y>", "2<c-y>")

keymap.set("n", "<leader>wr", ":set wrap<cr>")
-- " customize placeholder _TODO_
-- " nnoremap <leader><c-t> a_TODO_<esc>
-- nnoremap <leader><c-t> b/_TODO_<cr>:nohl<cr>"_c6l
-- nnoremap <leader>tt b/_TODO_<cr>:nohl<cr>"_c6l
-- inoremap <c-t> <esc>/_TODO_<cr>:nohl<cr>"_c6l

-- tab
keymap.set("n", "tu", ":tabe<cr>")
keymap.set("n", "tn", ":tabnew<cr>")
keymap.set("n", "t=", ":tabmove +<cr>")
keymap.set("n", "t-", ":tabmove -<cr>")

-- run vim run
keymap.set("n", "<leader>rr", ":call RunVimRun()<cr>")
keymap.set("n", "<leader>rt", ":call RunVimTest()<cr>")

--
-- lazy plugins
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git", "clone", "--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath,
	})
end
opt.rtp:prepend(lazypath)

require("lazy").setup({

	require("pl-completion"),
	require("pl-telescope"),
	require("pl-lsp"),
	require("pl-explorer"),
	require("pl-language"),
	require("pl-format"),
	require("pl-tpope"),

	-- require("pl-copilot"),
	require("pl-comment"),
	require("pl-snippet"),
	require("pl-navigation"),
	require("pl-ornament"),

	-- keybinding & command
	{
		"folke/which-key.nvim",
		opts = { preset = "mordern" },
		-- stylua: ignore
		keys = { { "<leader>?", function() require("which-key").show({ global = false }) end } },
	},
	-- wilder
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"rcarriga/nvim-notify",
				opts = {
					background_colour = "#000000",
					on_open = function(win)
						vim.api.nvim_win_set_config(win, { focusable = false })
					end,
				}
			},
		},
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires nvim-cmp
				},
			},
			presets = {
				bottom_search = false,    -- use a classic bottom cmdline for search
				command_palette = true,   -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false,       -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false,   -- add a border to hover docs and signature help
			},
		},
	},

	-- editing
	{
		-- narrow region
		{
			"andrewradev/inline_edit.vim",
			keys = { { "<leader>nr", mode = "v", "<cmd>InlineEdit<cr>" } },
			config = function()
				vim.g.inline_edit_autowrite = 1
			end,
		},

		{ "vim-scripts/swapcol.vim", cmd = { "Swapcols" } },
		{ "tani/dmacro.vim",         keys = { { "<c-y>", mode = { "n", "i" }, "<Plug>(dmacro-play-macro)" } } },

		-- increment
		{
			"monaqa/dial.nvim",
			events = "VeryLazy",
			keys = {
				{ "<c-a>", mode = { "n", "v" }, "<Plug>(dial-increment)" },
				{ "<c-x>", mode = { "n", "v" }, "<Plug>(dial-decrement)" },
			},
			config = function()
				local augend = require("dial.augend")
				local weekdays = augend.constant.new({
					elements = { "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday" },
					word = true,
					cyclic = true,
				})
				require("dial.config").augends:register_group({
					default = {
						augend.integer.alias.decimal,
						augend.constant.alias.bool,
						augend.date.alias["%Y/%m/%d"],
						weekdays,
					},
				})
			end,
		},

		{ "windwp/nvim-autopairs",           event = "InsertEnter",                 opts = { disable_filetype = { "TelescopePrompt", "vim" } } },

		-- information
		{ "RRethy/vim-illuminate",           event = "VeryLazy",                    keys = { { "<leader>ll", "<cmd>IlluminateToggle<cr>" } } },
		{ "bronson/vim-trailing-whitespace", event = { "BufReadPre", "BufNewFile" } },
		{ "kevinhwang91/nvim-bqf",           ft = "qf" },

		-- selection
		{
			"sustech-data/wildfire.nvim",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = { "nvim-treesitter/nvim-treesitter" },
			opts = {},
		},
	},

	-- diagnostics, references, etc
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (Trouble)", },
			{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics (Trouble)", },
			{ "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols (Trouble)" },
			{ "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)", },
			{ "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location List (Trouble)", },
			{ "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List (Trouble)", },
		},
	},

	-- others
	{ "sindrets/diffview.nvim", cmd = { "DiffviewOpen", "DiffviewFileHistory" } },
})

-- end of lazy plugins

require("builtin")
require("custom-fn")
require("neovide")
