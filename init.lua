--
-- defaults
--
local opt    = vim.opt
local keymap = vim.keymap


-- for nvim-tree
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- apperance
opt.termguicolors        = true
opt.signcolumn           = "yes"
-- vim.cmd[[colorscheme gruvbox]]

-- display
opt.relativenumber       = true
opt.wrap                 = false
opt.cursorline           = true
opt.hidden               = true;
opt.showcmd              = false;
opt.inccommand           = "nosplit";

-- scroll
opt.scrolloff            = 4;
opt.sidescrolloff        = 10;
opt.laststatus           = 2;

-- enable mouse
-- opt.mouse:append("a")
opt.mouse                = "nv";

-- split window
opt.splitright           = true
opt.splitbelow           = true

-- search
opt.ignorecase           = true
opt.smartcase            = true
opt.incsearch            = true;
opt.hlsearch             = true;
-- opt.wildignorecase = true;

-- temp files, backup, swap, etc
opt.backup               = false;
opt.writebackup          = false;
opt.swapfile             = false;

-- spell
opt.spell                = false;

-- errorbell
opt.errorbells           = false;

-- match bracket
opt.showmatch            = true;
opt.matchtime            = 2;

-- editing
opt.autoread             = true; -- auto read if file is modified in other place
opt.title                = true;
opt.wildmenu             = true;

-- history
opt.history              = 1000;

-- fold
opt.foldenable           = true;
opt.foldmethod           = "indent"
opt.foldlevel            = 99
opt.foldenable           = true
opt.foldlevelstart       = 99

-- indentation
opt.autoindent           = true;
opt.tabstop              = 4;
opt.shiftwidth           = 4;
opt.softtabstop          = 4;
opt.expandtab            = true;
opt.smartindent          = true;
vim.cmd [[autocmd FileType lua,jsom,yaml setlocal ts=2 sts=2 sw=2]]
vim.cmd [[autocmd FileType json set formatprg=jq]]
vim.cmd [[autocmd BufNewFile,BufRead *.typst set filetype=typst]]
vim.cmd [[autocmd BufNewFile,BufRead *.typ set filetype=typst]]

-- appearance
opt.number           = true;
opt.textwidth        = 120;

-- undo file
opt.undofile         = false;

-- faster scroll
opt.ttyfast          = true;
opt.lazyredraw       = true;

-- window local
vim.wo.wrap          = false;

--
-- keymaps
--

vim.g.mapleader      = "," -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.localmapleader = ","
local bufopts        = { silent = true, noremap = true }

keymap.set("n", "<esc>", ":nohl<CR>")
keymap.set("n", "Q", "<nop>")
keymap.set("n", "<c-q>", "<nop>")

-- buffer
keymap.set("n", "[b", ":bprevious<CR>")
keymap.set("n", "]b", ":bnext<CR>")

keymap.set("v", "Y", '"+y')
keymap.set("n", "<leader>ft", ":set ft=")

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

-- nnoremap <leader>wp :set wrap<cr>
-- " customize placeholder _TODO_
-- " nnoremap <leader><c-t> a_TODO_<esc>
-- nnoremap <leader><c-t> b/_TODO_<cr>:nohl<cr>"_c6l
-- nnoremap <leader>tt b/_TODO_<cr>:nohl<cr>"_c6l
-- inoremap <c-t> <esc>/_TODO_<cr>:nohl<cr>"_c6l

-- " Create a new tab with tu
-- nnoremap tu :tabe<CR>
-- nnoremap tn :tabnew<cr>
-- " Move the tabs with tn and ti
-- nnoremap t+ :tabmove +<CR>
-- nnoremap t- :tabmove -<CR>

-- run vim run
keymap.set("n", "<leader>rr", ":call RunVimRun()<cr>")
keymap.set("n", "<leader>rt", ":call RunVimTest()<cr>")

--
-- lazy plugins
--

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- decoration
  {
    -- theme
    {
      -- "srcery-colors/srcery-vim",
      "morhetz/gruvbox",
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
        -- load the colorscheme here
        vim.g.gruvbox_contrast_dark = "hard"
        vim.cmd([[colorscheme gruvbox]])
      end
    },

    -- status bar
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        require("lualine").setup({
          options = { theme = "gruvbox" },
        })
      end
    },

    -- welcome
    {
      "mhinz/vim-startify",
      config = function()
        vim.g.startify_change_to_dir = 0
        vim.g.startify_change_to_vcs_root = 1
        vim.g.startify_session_dir = "$HOME/.vim/sessions"
        vim.g.startify_files_number = 20
      end
    },

    -- { "echasnovski/mini.nvim", version = false },

    -- signs
    {
      "lewis6991/gitsigns.nvim",
      lazy = true,
      config = function()
        require("gitsigns").setup({
          signs = {
            add = { text = "+" },
            change = { text = "~" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
          },
        })
      end
    },
  },

  -- editing
  {
    "tpope/vim-repeat",
    {
      "andrewradev/inline_edit.vim", -- narrow region
      config = function()
        vim.g.inline_edit_autowrite = 1
        keymap.set("v", "<leader>nr", ":InlineEdit<cr>")
      end
    },
    -- auto increment, vis & visincr
    "vim-scripts/vis",
    -- :B, :S
    "vim-scripts/VisIncr",
    -- :I, :I -1, :II, etc
    "jiangmiao/auto-pairs",
    "vim-scripts/swapcol.vim",

    -- conversion
    "tpope/vim-abolish",
    "tpope/vim-surround",
    -- "scrooloose/nerdcommenter",
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup({
          -- Add a space b/w comment and the line
          padding = true,
          -- Whether the cursor should stay at its position
          sticky = true,
          mappings = {
            basic = true,
            extra = false,
          }
        })
      end
    },

    -- format
    "nvie/vim-rst-tables",
    {
      "dhruvasagar/vim-table-mode",
      config = function()
        keymap.set("n", "<leader>tm", ":TableModeToggle<cr>")
      end
    },
    "godlygeek/tabular",

    -- information
    "tpope/vim-fugitive",
    {
      "RRethy/vim-illuminate",
      config = function()
        keymap.set("n", "<leader>ll", ":IlluminateToggle<cr>")
      end
    },
    "bronson/vim-trailing-whitespace",
    { "tversteeg/registers.nvim", branch = "main", },

    -- splitjoin
    {
      "Wansmer/treesj",
      dependencies = { "nvim-treesitter/nvim-treesitter" },
      keys = { { "gS", "<cmd>TSJToggle<cr>" } },
      config = function()
        require("treesj").setup({
          use_default_keymaps = false,
          max_join_length = 240,
          dot_repeat = true,
        })
      end,
    },

    -- selection
    {
      "gcmt/wildfire.vim",
      config = function()
        vim.g.wildfire_objects = { "iw", "i'", 'i"', "i)", "i]", "i}", "ip", "it" }
      end
    },
  },

  -- syntax (treesitter)
  {
    "nvim-treesitter/playground",
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      priority = 1000,
      build = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          -- add languages
          ensure_installed = {
            "bash", "query",
            "c", "cpp",
            "json",
            "javascript", "typescript", "tsx", "css",
            "lua",
            "python",
            -- "rust",
            "go",
            "markdown", "markdown_inline",
            "typst",
            "vim",
          },

          highlight = { enable = true, disable = {} },
          indent = { enable = true },
          -- incremental_selection = {}

          rainbow = {
            enable = true,
            extended_mode = true,
            max_file_lines = nil,
          },
        }
      end
    }
  },
  -- "p00f/nvim-ts-rainbow", -- rainbow bracket

  -- lsp
  {
    {
      "neovim/nvim-lspconfig",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local util = require "lspconfig/util"

        -- refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = buffer,
          callback = function()
            vim.lsp.buf.format { async = false }
          end
        })

        require("lspconfig").gopls.setup({
          cmd = { "gopls", "serve" },
          fieltypes = { "go", "gomod", "gowork", "gotmpl" },
          root_dir = util.root_pattern("go.work", "go.mod", ".git"),
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              gofumpt = true,
              staticcheck = true,
            },
          },
        })

        -- gofumpt on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
          end
        })

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { silent = true }
        -- keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts) -- wrong cmd
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        keymap.set("n", "gr", vim.lsp.buf.references, opts)
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
        keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        require("lspconfig").lua_ls.setup {
          capabilities = capabilities,
          settings = { Lua = { diagnostics = { globals = { "vim" } } } } -- ignore vim global in nvim config
        }
        require("lspconfig").marksman.setup {}
        require("lspconfig").pyright.setup {}
        require("lspconfig").rust_analyzer.setup {}
      end
    },
    {
      "williamboman/mason.nvim",
      lazy = false,
      build = ":MasonUpdate", -- :MasonUpdate updates registry contents
      config = function()
        require("mason").setup({
          ui = {
            icons = {
              package_installed = "✓",
              package_pending = "➜",
              package_uninstalled = "✗"
            }
          }
        })
      end
    },
    {
      "williamboman/mason-lspconfig.nvim", -- a bridge between mason.nvim and lspconfig
      lazy = false,
      dependencies = { "neovim/nvim-lspconfig", },
      config = function()
        require("mason-lspconfig").setup({
          ensure_installed = {
            "gopls",         -- golang
            "lua_ls",        -- lua
            "marksman",      -- markdown
            "pyright",       -- python
            "rust_analyzer", -- rust
          },
          automatic_installation = true,
        })
      end
    },
  },
  -- golang
  {
    "ray-x/go.nvim",
    ft = { "go", "gomod", "gowork", "gotmpl" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- local lsp = require("plugins.lsp")
      require("go").setup({
        go = "go",
        goimports = "gopls",
        gofmt = "gofumpt",
        fillstruct = "gopls",
        -- max_line_len = 256,

        lsp_cfg = true,
        -- lsp_on_attach = lsp.on_attach,
        lsp_gofumpt = true,
        lsp_codelens = true,
        lsp_inlay_hints = { enable = false },

        luasnip = true,
      })

      -- snippet
      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      require("go").setup({
        -- other setups ....
        lsp_cfg = {
          capabilities = capabilities,
          -- other setups
        },
      })

      -- -- use format from lsp
      -- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   pattern = "*.go",
      --   callback = function()
      --     require("go.format").goimport()
      --   end,
      --   group = format_sync_grp,
      -- })
    end,
  },

  -- completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-copilot",
      "hrsh7th/cmp-path", -- file path

      "github/copilot.vim",
      -- snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-e>"] = cmp.mapping.abort(), -- exit completion, esc works too
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),

        formatting = {
          fields = { "abbr", "menu" },

          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[Lsp]",
              luasnip = "[LuaSnip]",
              buffer = "[File]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "copilot" },
          { name = "path" },
        }, { { name = "buffer" }, })
      })
    end
  },

  -- snippets
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    config = function()
      local ls = require("luasnip")
      local lssnip = ls.snippet
      local lsfunc = ls.function_node

      ls.add_snippets("all", {
        lssnip("dt", lsfunc(function() return os.date("%Y-%m-%d") end, {})),
        lssnip("ts10", lsfunc(function() return tostring(os.time()) end, {})),
        lssnip("ts13", lsfunc(function() return tostring(os.time() * 1000) end, {})),
      })
    end
  },

  -- copilot
  {
    "github/copilot.vim",
    -- branch = "release",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_enabled = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_no_tab_map = true
      -- vim.api.nvim_set_keymap("i", "<c-p>", "<Plug>(copilot-suggest)", {})
      -- vim.api.nvim_set_keymap("i", "<c-n>", "<Plug>(copilot-next)", { silent = true })
      -- vim.api.nvim_set_keymap("i", "<c-l>", "<Plug>(copilot-previous)", { silent = true })
      vim.cmd('imap <silent><script><expr> <C-J> copilot#Accept("")')
      vim.cmd([[
        let g:copilot_filetypes = {
        \ "TelescopePrompt": v:false,
        \ }
        ]])
    end
  },

  -- navigation
  {
    "christoomey/vim-tmux-navigator",

    {
      "nvim-telescope/telescope.nvim",
      branch = "master",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          "nvim-tree/nvim-web-devicons",
          dependencies = { "junegunn/fzf.vim" },
          build = "make",
          config = function()
            require("telescope").load_extension("fzf")
          end
        },
      },
      config = function()
        local builtin = require("telescope.builtin")
        keymap.set("n", "<leader>ff", builtin.find_files, {})
        keymap.set("n", "<leader>fg", builtin.live_grep, {})
        keymap.set("n", "<leader>fb", builtin.buffers, {})
        keymap.set("n", "<leader>fh", builtin.help_tags, {})

        keymap.set("n", "<leader>sf", builtin.live_grep, {})
        keymap.set("n", "<leader>bb", builtin.buffers, {})
        keymap.set("n", "<leader>dd", builtin.diagnostics, {})
        keymap.set("n", "<leader>ts", builtin.treesitter, {})
        keymap.set("n", "gr", builtin.lsp_references, {})
        keymap.set("n", "gb", builtin.git_branches, {})

        local actions = require("telescope.actions")
        require("telescope").setup({
          defaults = {
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--fixed-strings",
              "--smart-case",
              "--trim",
            },
            layout_config = {
              width = 0.8,
              height = 0.8,
            },
            file_previewer = require("telescope.previewers").vim_buffer_cat.new,
            grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          },
          pickers = {
            buffers = {
              show_all_buffers = true,
              sort_lastused = true,
              mappings = {
                i = {
                  ["<c-d>"] = actions.delete_buffer,
                },
              }
            },
          },
        })
      end
    }
  },
  -- explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", opt = true },
    config = function()
      keymap.set("n", "<leader>ee", ":NvimTreeToggle<cr>")

      require("nvim-tree").setup({
        auto_reload_on_write = true,
        update_focused_file = { enable = true },
        diagnostics = { enable = false, },
        actions = {
          open_file = { quit_on_open = true, },
        },
        update_cwd = true,
      })
      vim.cmd([[doautocmd NvimTree BufEnter *]])
    end
  },
  -- languages
  {
    {
      "iamcco/markdown-preview.nvim",
      ft = "markdown",
      build = function() vim.fn["mkdp#util#install"]() end,
      config = function()
        local g = vim.g
        g.mkdp_auto_start = 0
        g.mkdp_auto_close = 1
        g.mkdp_refresh_slow = 0
        g.mkdp_command_for_global = 0
        g.mkdp_open_to_the_world = 0
        g.mkdp_open_ip = ''
        g.mkdp_echo_preview_url = 0
        g.mkdp_browserfunc = ''
        g.mkdp_markdown_css = ''
        g.mkdp_highlight_css = ''
        g.mkdp_port = ''
        g.mkdp_page_title = "「${name}」"
        g.mkdp_preview_options = {
          disable_sync_scroll = 0,
          sync_scroll_type = "middle",
          hide_yaml_meta = 1,
        }
      end
    },
    {
      "chomosuke/typst-preview.nvim",
      ft = "typst",
      version = "0.1.*",
      build = function() require "typst-preview".update() end,
    },
    {
      "scalameta/nvim-metals",
      ft = { "scala" },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
      },
      config = function()
        local metals_config = require("metals").bare_config()

        -- Example of settings
        metals_config.settings = {
          showImplicitArguments = true,
          excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
        }
        metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      end
    },
    {
      "jceb/vim-orgmode",
      ft = { "org" },
    },
  },

  -- others
  -- require("plugins.wilder"),
})

--
-- custom funcs
--

vim.api.nvim_exec([[
  command! TidyJIRA call TidyJIRAFunc()
  function! TidyJIRAFunc()
    :set ft=markdown
    :v/SPPC/d
    :%s/\(SPPC-\d\{5\}\)\s*\nSPPC-\d\{5\}\s*/[[\1](https:\/\/jira.shopee.io\/browse\/\1)] /
    :%norm A
  endfunc
]], true)

vim.api.nvim_exec([[
func! RunVimRun()
  :w
  if &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'go'
    " :GoRun
    set splitbelow
    :sp
    :term go run %
  elseif &filetype == 'python'
    set splitbelow
    :sp
    :term python3 %
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  elseif &filetype == 'typst'
    exec "TypstPreview"
  elseif &filetype == 'xhtml'
    :!open % -a Google\ Chrome
  elseif &filetype == 'dot'
    let current_file_name=expand('%:r')
    let output_file_path=current_file_name . '.png'
    exec "!dot -Tpng % -o " . output_file_path
    exec "!open " . output_file_path
  elseif &filetype == 'mermaid'
    " let current_file_name=expand('%:r')
    " let output_file_path=current_file_name . '.png'
    " exec "!mmdc -H -i " . current_file_name . ".mmd -o " output_file_path . " -t bright -b transparent"
    " exec "!open " . output_file_path
    exec "!mermaid %"
  elseif &filetype == 'scala'
    set splitbelow
    :sp
    :term scala %
  endif
endfunc
]], true)

vim.api.nvim_exec([[
func! RunVimTest()
  :w
  if &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'go'
    :GoTestFile -v
  endif
endfunc
]], true)

--
-- for neovide
--
if vim.g.neovide then
  vim.g.neovide_transparency            = 0.8
  vim.g.neovide_hide_mouse_when_typing  = true
  vim.g.neovide_no_idle                 = false
  vim.g.neovide_fullscreen              = true
  vim.g.neovide_remember_window_size    = true
  vim.g.neovide_cursor_animation_length = 0.1
  vim.g.neovide_cursor_antialiasing     = false
  vim.g.neovide_cursor_vfx_mode         = "torpedo"

  keymap.set('n', '<D-s>', ':w<CR>')      -- Save
  keymap.set('v', '<D-c>', '"+y')         -- Copy
  keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
  keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
  keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
  keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })
end
