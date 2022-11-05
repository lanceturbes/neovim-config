# Basic Neovim Configuration

This is my personal neovim configuration as a web developer.

This configuration is primarily lua-based and uses Packer to manage plugins. Has support for TypeScript/React, Elm, and Lua.

### Disclaimer

I am sharing this configuration as-is and offer no support if something goes wrong.

If you want an all-in-one configuration for Neovim, [LunarVim](https://www.lunarvim.org/) and [Astrovim](https://github.com/AstroNvim/AstroNvim) are great choices.

All plugins I am using have been linked above so you may easily check them out yourself and send bug reports to the original authors in order to help them improve.

### Table of Contents

- [Quick Start](#getting-started)
- [Plugins/Extensions](#plugin-list)
  - [Core](#core)
  - [Language Support/Helpers](#language-support/helpers)
  - [Workspace Tools](#workspace-tools)
  - [Appearance](#appearance)
  - [Extras](#extras)
- [Credits](#credits)

## Getting Started

### Prerequisites

- A GNU/Linux distribution (paths for commands/functions assume a GNU/Linux directory scheme)
- Neovim 0.8+ (I recommend using [Bob](https://github.com/MordechaiHadad/bob) to manage Neovim versions on your system.)
- [lazygit](https://github.com/jesseduffield/lazygit#installation) (friendly GUI for git; required by its integration plugin)
- (optional) [ripgrep](https://github.com/BurntSushi/ripgrep#installation) (for highly enhanced file search with telescope)

### Installation

First, back up your current neovim configuration (if you have one; otherwise, skip this step):

```bash
cp -r ~/.config/nvim ~/.config/nvim-backup
```

Next, clone this repository to your machine and move its contents to your neovim configuration directory:

```bash
cd ~/Downloads
git clone https://github.com/lanceturbes/neovim-config.git
mv ./neovim-config ~/.config/nvim
```

Finally, launch Neovim and run `PackerSync` to install all the included extensions.

```bash
nvim +PackerSync
```

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
- [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim) (Integration for lazygit, a friendly interface for Git)

### Appearance

- [gruvbox-material](https://github.com/sainnhe/gruvbox-material) (Theme with earthy tones and good contrast)
- [nvim-lualine](https://github.com/nvim-lualine/lualine.nvim) (Performant and aesthetic status bar)

### Extras

- [vim-be-good](https://github.com/ThePrimeagen/vim-be-good) (Game to train Vim muscle memory through fun drills)

## Credits

Special thanks to [ThePrimagen](https://github.com/ThePrimeagen) for open-sourcing [his config](https://github.com/ThePrimeagen/.dotfiles/tree/master/nvim/.config/nvim) -- I used it as a reference while building this one. Also, [his YouTube channel](https://www.youtube.com/c/ThePrimeagen) has a lot of information about working with Vim and programming in-general, and his VimBeGood game is fun, too.
