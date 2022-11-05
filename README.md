# Basic Neovim Configuration

This is my personal neovim configuration as a web developer.

This configuration is primarily lua-based and uses Packer to manage plugins. Has support for TypeScript/React and Lua.

## Plugin list

### Core

- [packer](https://github.com/wbthomason/packer.nvim) (Package manager)
- [plenary](https://github.com/nvim-lua/plenary.nvim) (Collection of helpful Lua functions; dependency of other plugins)

### Language Support/Helpers

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) (Streamlined presets for working with language servers)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (Autocompletion)
- [LuaSnip](https://github.com/L3MON4D3/LuaSnip) (Snippet Engine)
- [null-ls](https://github.com/jose-elias-alvarez/null-ls.nvim) (Formatting/Diagnostics plus other helpers for LSP management)
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) (Advanced syntax highlighting and more)
- [nvim-autopairs](https://github.com/windwp/nvim-autopairs) (Automatically close pairs of quotes, parentheses, and more)
- [vim-commentary](https://github.com/tpope/vim-commentary) (Quickly comment/uncomment lines from visual mode)

### Workspace Tools

- [telescope](https://github.com/nvim-telescope/telescope.nvim) (Amazing lua-based fuzzy finder)
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim) (Show git diff indicators in the side gutter)
- [vim-fugitive](https://github.com/tpope/vim-fugitive) (Run git commands directly from Vim)

### Appearance

- [gruvbox-material](https://github.com/sainnhe/gruvbox-material) (Theme with earthy tones and good contrast)
- [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) (Performant and aesthetic status bar)

### Extras

- [vim-be-good](https://github.com/ThePrimeagen/vim-be-good) (Game to train Vim muscle memory through fun drills)

## Credits

Special thanks to [ThePrimagen](https://github.com/ThePrimeagen) for open-sourcing [his config](https://github.com/ThePrimeagen/.dotfiles/tree/master/nvim/.config/nvim) -- I used it as a reference while building this one. Also, [his YouTube channel](https://www.youtube.com/c/ThePrimeagen) has a lot of information about working with Vim and programming in-general, and his VimBeGood game is fun, too.

## Disclaimer

I am sharing this configuration as-is and offer no support if something goes wrong. 

If you want an all-in-one configuration for Neovim, [LunarVim](https://www.lunarvim.org/) and [Astrovim](https://github.com/AstroNvim/AstroNvim) are great choices.

All plugins I am using have been linked above so you may easily check them out yourself and send bug reports to the original authors in order to help them improve.
