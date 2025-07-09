return {
  "benlubas/molten-nvim",
  build = ":UpdateRemotePlugins",
  lazy  = false,               -- load at startup so commands are defined

  -- 1️⃣   Set options via globals in an `init` callback
  init = function()
    -- auto-open an output split every time you run code
    vim.g.molten_auto_open_output = true

    -- put that split on the right and style it
    vim.g.molten_split_direction  = "right"     -- "right" | "left" | "top" | "bottom"
    vim.g.molten_output_win_border = "rounded"
    vim.g.molten_output_win_max_width  = 45     -- columns
  end,

  -- 2️⃣   Key-maps etc. go in `config` (no call to setup!)
  config = function()
    local k = vim.keymap.set
    k("n", "<leader>oo", "<cmd>MoltenEnterOutput<cr>",
      { desc = "Jump to Molten output pane" })
    k("n", "<leader>oc", "<cmd>MoltenHideOutput<cr>",
      { desc = "Close output pane" })
  end,
}

