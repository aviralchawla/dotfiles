local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  ----------------------------------------------------------------------
  -- A. Look & feel
  ----------------------------------------------------------------------
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    opts = { flavour = "mocha" } },                   -- soothing pastel theme :contentReference[oaicite:0]{index=0}

  ----------------------------------------------------------------------
  -- B. LSP, completion & AI helpers
  ----------------------------------------------------------------------
  { "neovim/nvim-lspconfig" },                        -- base LSP client
  { "williamboman/mason.nvim", config = true },       -- language-server installer
  { "williamboman/mason-lspconfig.nvim" },            -- mason ↔︎ lspconfig bridge
  { "hrsh7th/nvim-cmp",                                -- autocompletion-engine
      dependencies = {
        "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip", "zbirenbaum/copilot-cmp"
      }
  },
  { "zbirenbaum/copilot.lua",  -- fast Copilot client for Neovim :contentReference[oaicite:1]{index=1}
      cmd = "Copilot", build = ":Copilot auth"
  },

  -- Gemini CLI inside Neovim (toggle with <leader>og) :contentReference[oaicite:2]{index=2}
  { "jonroosevelt/gemini-cli.nvim", cmd = "Gemini" },

  ----------------------------------------------------------------------
  -- C. Python, Jupyter & interactive shells
  ----------------------------------------------------------------------
  { "benlubas/molten-nvim", build = ":UpdateRemotePlugins" }, -- run cells via Jupyter kernel :contentReference[oaicite:3]{index=3}
  { "goerz/jupytext.nvim", ft = { "ipynb" } },                -- open *.ipynb as text :contentReference[oaicite:4]{index=4}
  { "akinsho/toggleterm.nvim", version = "*", config = true },-- pop-up terminals :contentReference[oaicite:5]{index=5}

  ----------------------------------------------------------------------
  -- D. Git & workflow
  ----------------------------------------------------------------------
  "tpope/vim-fugitive",                        -- :Git, :Gdiff, …
  { "lewis6991/gitsigns.nvim", config = true },-- gutter blame / hunk actions
  { "kdheepak/lazygit.nvim",                   -- LazyGit UI in a float :contentReference[oaicite:6]{index=6}
      dependencies = { "akinsho/toggleterm.nvim" }
  },

  ----------------------------------------------------------------------
  -- E. Telescope search & Treesitter syntax goodness
  ----------------------------------------------------------------------
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
})

------------------------------------------------------------------
-- Gitsigns ─ show added/changed/deleted lines in the signcolumn
------------------------------------------------------------------
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
------------------------------------------------------------------
-- 2. Basic options & mappings (Space = <leader>)
------------------------------------------------------------------
vim.g.mapleader = " "
vim.o.number      = true
vim.o.relativenumber = true
vim.o.termguicolors  = true
vim.cmd.colorscheme "catppuccin"

local keymap = vim.keymap.set
-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find file" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  { desc = "Live grep" })
-- Terminal
keymap({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal" })
-- Molten (Jupyter)
keymap("n", "<leader>ip", "<cmd>MoltenInit python3<cr>", { desc = "Init python kernel" })
keymap({ "n", "v" }, "<leader>rr", "<cmd>MoltenEvaluate<cr>", { desc = "Run cell/selection" })
-- Copilot & Gemini
keymap("n", "<leader>cc", "<cmd>Copilot panel<cr>",   { desc = "Copilot Chat" })
keymap("n", "<leader>og", "<cmd>Gemini<cr>",          { desc = "Open Gemini CLI buffer" })
-- Git
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>",         { desc = "LazyGit" })
keymap("n", "<leader>gs", "<cmd>G<cr>",               { desc = "Git status (fugitive)" })
-- Gitsigns
local gs = require "gitsigns"

-- Navigation
keymap("n", "]c", function() gs.nav_hunk("next") end, { desc = "Next Git hunk" })
keymap("n", "[c", function() gs.nav_hunk("prev") end, { desc = "Prev Git hunk" })

-- Actions
keymap("n", "<leader>hs", gs.stage_hunk,      { desc = "Stage hunk" })
keymap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage" })
keymap("n", "<leader>hr", gs.reset_hunk,      { desc = "Reset hunk" })
keymap("n", "<leader>hR", gs.reset_buffer,    { desc = "Reset buffer" })
keymap("n", "<leader>hp", gs.preview_hunk,    { desc = "Preview hunk" })
keymap("n", "<leader>hb", function() gs.blame_line{ full=true } end,
                                            { desc = "Blame line (popup)" })
keymap("n", "<leader>ht", gs.toggle_current_line_blame,
                                            { desc = "Toggle inline blame" })
keymap("n", "<leader>hd", gs.diffthis,        { desc = "Diff this file" })
