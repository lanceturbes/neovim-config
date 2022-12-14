-- Checks if packer is installed, and if not, installs it.
-- Returns the status of whether packer needed to be bootstrapped.
local function initialize_packer()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

-- Whether a PackerSync operation should be run.
-- Determined by whether or not Packer was just bootstrapped.
local is_sync_needed = initialize_packer()

-- plugin setup
require("packer").startup(function(use)
	-- plugin manager
	use("wbthomason/packer.nvim")

	-- common dependencies
	use("nvim-lua/plenary.nvim")

	-- language server configuration
	use("neovim/nvim-lspconfig")

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- Autocompletion plugin
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use("saadparwaiz1/cmp_luasnip") -- Snippets source for nvim-cmp
	use("L3MON4D3/LuaSnip") -- Snippets plugin

	-- linting/formatting servers
	use("jose-elias-alvarez/null-ls.nvim")

	-- advanced syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- theme
	-- use("overcache/NeoSolarized")
	use("sainnhe/gruvbox-material")

	-- vim game (for practicing motions)
	use("ThePrimeagen/vim-be-good")

	-- pretty status line
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finder
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- automatically close pairs
	use({ "windwp/nvim-autopairs" })

	-- show git diffs in gutter
	use("lewis6991/gitsigns.nvim")

	-- allow easy commenting/uncommenting
	use("tpope/vim-commentary")

	-- easy git access
	use("kdheepak/lazygit.nvim")

	if is_sync_needed then
		require("packer").sync()
	end
end)
