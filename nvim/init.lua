vim.g.mapleader = " "
vim.o.number      = true
vim.o.relativenumber = true
vim.o.termguicolors  = true


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { import = "plugins" },
  { "neovim/nvim-lspconfig" },                        -- base LSP client
  { "williamboman/mason.nvim", config = true },       -- language-server installer
  { "williamboman/mason-lspconfig.nvim" },            -- mason ↔︎ lspconfig bridge
  { "hrsh7th/nvim-cmp",                                -- autocompletion-engine
      dependencies = {
        "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip", "zbirenbaum/copilot-cmp"
      }
  },
  { "terrortylor/nvim-comment" },
  { "zbirenbaum/copilot.lua", cmd = "Copilot", build = ":Copilot auth"},
  { "jonroosevelt/gemini-cli.nvim", cmd = "Gemini" },
  {
  "goerz/jupytext.nvim",
  version = "0.2.0",      -- or branch = "main"
  lazy = false,           -- load at startup (it’s tiny)
  opts = {                -- optional tweaks
    format = "markdown",  -- or "py:percent", "auto", …
  }},
  { "akinsho/toggleterm.nvim", version = "*", config = true },-- pop-up terminals :contentReference[oaicite:5]{index=5}
  "tpope/vim-fugitive",                        -- :Git, :Gdiff, …
  { "lewis6991/gitsigns.nvim", config = true },-- gutter blame / hunk actions
  { "kdheepak/lazygit.nvim",                   -- LazyGit UI in a float :contentReference[oaicite:6]{index=6}
      dependencies = { "akinsho/toggleterm.nvim" }
  },
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})
require("gitsigns").setup({
  signs = {
    add          = { text = "+" },
    change       = { text = "│" },
    delete       = { text = "-" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "?" },
  },
  signs_staged_enable = true,   -- show ✓ when a hunk is staged
  current_line_blame   = false,  -- toggleable inline blame
  preview_config = { border = "rounded" },
})
require("copilot").setup({})
require("copilot_cmp").setup()
require('lualine').setup()
require('nvim_comment').setup()
require('neo-tree').setup()
require('bufferline').setup()
require('keymaps.all')

vim.cmd.colorscheme "catppuccin"
vim.opt.splitright = true
