-- helpers for setting options/keybindings
local set = vim.opt -- set vim options
local let = vim.g -- create vim variables
local bind = vim.keymap.set -- create vim keybindings

-- options
set.autoindent = true -- inherit indent of previous lines
set.backup = false -- don't save backup files
set.completeopt = { "menu", "menuone", "noselect" } -- use autocomplete within these areas
set.cursorline = true -- highlight line where cursor is
set.expandtab = true -- use spaces instead of tabs
set.hidden = true -- hide files in bg instead of closing them
set.history = 1000 -- store last 1000 commands in history
set.ignorecase = true -- make search case-insensitive
set.incsearch = true -- incrementally highlight the doc as you search
set.mouse = "a" -- allow mouse for selecting/scrolling through text
set.relativenumber = true -- add line numbers relative to cursor
set.scrolloff = 10 -- scroll once cursor is 10 lines from top/bottom
set.shiftround = true -- round indent to neareast mutliple of shiftwidth
set.shiftwidth = 4 -- set shift width to 4 spaces
set.showmatch = true -- show matching words during search
set.showmode = false -- don't show the current mode at bottom of vim
set.smartcase = true -- make search case-sensitive if using capitals
set.smarttab = true -- insert tabstop spaces when tab is pressed
set.swapfile = false -- disable use of swap files
set.tabstop = 4 -- set tab width to 4 spaces
set.wildmenu = true -- allow tab autocomplete
set.wrap = true -- wrap lines which hit screen edge

-- variables
let.mapleader = "<space>" -- set <leader> key to space bar -- default is backslash

-- check if packer (plugin manager) is installed
-- if not, download and install it automatically
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- setup code completion
local cmp_ok, _ = pcall(require, "cmp")
if cmp_ok then
	local cmp = require("cmp")
	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		window = {
			-- completion = cmp.config.window.bordered(),
			-- documentation = cmp.config.window.bordered(),
		},
		mapping = cmp.mapping.preset.insert({
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.abort(),
			["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" }, -- For luasnip users.
		}, {
			{ name = "buffer" },
		}),
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype("gitcommit", {
		sources = cmp.config.sources({
			{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = "buffer" },
		}),
	})
end

-- setup language servers (code highlighting/documentation helpers)
local cmp_nvim_lsp_ok, _ = pcall(require, "cmp_nvim_lsp")
if cmp_nvim_lsp_ok then
	-- import default capabilities of neovim completion plugin
	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- set group to run formatting commands under
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	-- only format documents using null-ls (for eslint, prettier, etc.)
	local format_on_save_filter = function(client)
		return client.name == "null-ls"
	end

	-- function to run after a language server activates
	local on_attach = function(client, bufnr)
		-- setup keybinds for use with neovim's lsp
		bind("n", "K", vim.lsp.buf.hover, { buffer = 0 })
		bind("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
		bind("n", "gt", vim.lsp.buf.type_definition, { buffer = 0 })
		bind("n", "<space>df", vim.diagnostic.goto_next, { buffer = 0 })

		-- format on save
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr, filter = format_on_save_filter })
				end,
			})
		end
	end

	-- configure typescript lsp
	require("lspconfig").tsserver.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	-- configure lua lsp
	require("lspconfig").sumneko_lua.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})
end

-- setup null-ls (to manage linting, formatting, diagnostics)
local null_ls_ok, _ = pcall(require, "null-ls")
if null_ls_ok then
	local null_ls = require("null-ls")
	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.diagnostics.eslint,
			null_ls.builtins.completion.spell,
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.prettierd,
		},
	})
end

-- setup treesitter (fast/highly-detailed code highlighting)
local treesitter_ok, _ = pcall(require, "nvim-treesitter")
if treesitter_ok then
	require("nvim-treesitter.configs").setup({
		-- list of language parsers to install automatically
		ensure_installed = {
			"typescript",
			"tsx",
			"javascript",
			"html",
			"lua",
			"css",
			"bash",
			"json",
			"rust",
			"sql",
		},

		-- Install parsers synchronously (only applied to `ensure_installed`)
		sync_install = false,

		-- Automatically install missing parsers when entering buffer
		-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
		auto_install = false,

		-- List of parsers to ignore installing (for "all")
		-- ignore_install = { "javascript" },

		---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
		-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

		highlight = {
			-- `false` will disable the whole extension
			enable = true,

			-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
			-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
			-- the name of the parser)
			-- list of language that will be disabled
			-- disable = { "c", "rust" },
			-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
			-- disable = function(lang, buf)
			-- 	local max_filesize = 100 * 1024 -- 100 KB
			-- 	local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
			-- 	if ok and stats and stats.size > max_filesize then
			-- 		return true
			-- 	end
			-- end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
		},
	})
end

-- set color scheme/theme for the entire editor
local colorscheme_ok, _ = pcall(vim.cmd, [[colorscheme tokyonight]])
if colorscheme_ok then
	vim.cmd([[colorscheme tokyonight]])
end

-- setup telescope (fuzzy finder)
local telescope_ok, _ = pcall(require, "telescope")
if telescope_ok then
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "ff", builtin.find_files, {})
	vim.keymap.set("n", "fg", builtin.live_grep, {})
	vim.keymap.set("n", "fb", builtin.buffers, {})
	vim.keymap.set("n", "fh", builtin.help_tags, {})
end

-- setup lualine (status line at the bottom of the editor)
local lualine_ok, _ = pcall(require, "lualine")
if lualine_ok then
	require("lualine").setup({
		options = {
			theme = "tokyonight",
		},
	})
end

-- setup git signs (for line changes; displayed in left-side gutter)
local gitsigns_ok, _ = pcall(require, "gitsigns")
if gitsigns_ok then
	require("gitsigns").setup()
end

-- setup packer (plugin manager)
return require("packer").startup(function(use)
	-- plugin manager core
	use("wbthomason/packer.nvim")

	-- useful lua functions (similar to lodash; required by some plugins)
	use("nvim-lua/plenary.nvim")

	-- quick configuration plugin for language servers
	use("neovim/nvim-lspconfig")

	-- better syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
	})

	-- code completion plugins for different editor areas
	use("hrsh7th/cmp-nvim-lsp") -- nvim cmp from content within lsp
	use("hrsh7th/cmp-buffer") -- nvim cmp from content within buffer
	use("hrsh7th/nvim-cmp") -- autocompletion
	use({ "L3MON4D3/LuaSnip", tag = "v1.1.*" }) -- snippet engine
	use("jose-elias-alvarez/null-ls.nvim") -- formatting/linting

	-- automatic pair closing (for quotes, parens, etc.)
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	-- fuzzy finder (similar to CTRL+P in vscode)
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- color schemes/statusline
	use("folke/tokyonight.nvim")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- git integration plugins
	use("lewis6991/gitsigns.nvim") -- add change indicators in the gutter
	use("tpope/vim-fugitive") -- allow usage of git commands from command mode

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if ensure_packer() then
		require("packer").sync()
	end
end)
