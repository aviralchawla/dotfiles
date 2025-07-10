return {
  "benlubas/molten-nvim",
  build = ":UpdateRemotePlugins",
  init = function()
    vim.g.molten_split_direction   = "right"     -- right|left|top|bottom
    vim.g.molten_split_size        = 40          -- % of columns for the pane
    vim.g.molten_auto_open_output  = false       -- leave pane open between cells
    vim.g.molten_output_virt_lines = true        -- keep code visible
    vim.g.molten_output_show_more  = true        -- footer w/ overflow lines
    vim.g.molten_output_win_hide_on_leave = false
    vim.g.molten_enter_output_behavior   = "open_and_enter"
  end,
  config = function()
    local k = vim.keymap.set
    k("n", "<leader>oo",
  ":noautocmd MoltenEnterOutput<CR>",
  { desc = "Jump to Molten output pane", silent = true })
    k("n", "<leader>oc", "<cmd>MoltenHideOutput<cr>",
      { desc = "Close output pane" })
  end,
}


