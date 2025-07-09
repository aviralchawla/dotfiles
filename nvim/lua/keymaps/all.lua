local keymap = vim.keymap.set

-- General

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find file" })
-- keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>",  { desc = "Live grep" })

-- Terminal
keymap({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle terminal" })

-- Molten (Jupyter)
keymap("n", "<leader>ip", "<cmd>MoltenInit python3<cr>", { desc = "Init python kernel" })
keymap({ "n", "v" }, "<leader>rr", "<cmd>MoltenEvaluate<cr>", { desc = "Run cell/selection" })
keymap("n", "<leader>r", ":MoltenEvaluateOperator<CR>", { desc = "Molten: run motion" })
-- -- Custome Envs
keymap("n", "<leader>isc", ":MoltenInit social-choice<CR>", { desc = "Start Jupyter kernel: social-choice" })
keymap("n", "<leader>icc", ":MoltenInit cc<CR>", { desc = "Start Jupyter kernel: cc" })
-- -- Evaluation Fix
keymap("n", "<leader>rr", ":MoltenEvaluateLine<CR>", { desc = "Molten: run current line" })
keymap("v", "<leader>rr", ":<C-u>MoltenEvaluateVisual<CR>", { desc = "Molten: run selection" })

-- Gemini
keymap("n", "<leader>og", "<cmd>Gemini<cr>",          { desc = "Open Gemini CLI buffer" })

-- Git
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>",         { desc = "LazyGit" })
keymap("n", "<leader>gs", "<cmd>G<cr>",               { desc = "Git status (fugitive)" })

-- Gitsigns
local gs = require "gitsigns"
-- -- Navigation
keymap("n", "]c", function() gs.nav_hunk("next") end, { desc = "Next Git hunk" })
keymap("n", "[c", function() gs.nav_hunk("prev") end, { desc = "Prev Git hunk" })
-- -- Actions
keymap("n", "<leader>hs", gs.stage_hunk,      { desc = "Stage hunk" })
keymap("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage" })
keymap("n", "<leader>hr", gs.reset_hunk,      { desc = "Reset hunk" })
keymap("n", "<leader>hR", gs.reset_buffer,    { desc = "Reset buffer" })
keymap("n", "<leader>hp", gs.preview_hunk,    { desc = "Preview hunk" })
keymap("n", "<leader>hb", function() gs.blame_line{ full=true } end, { desc = "Blame line (popup)" })
keymap("n", "<leader>ht", gs.toggle_current_line_blame, { desc = "Toggle inline blame" })
keymap("n", "<leader>hd", gs.diffthis, { desc = "Diff this file" })

-- Neotree
keymap("n", "<leader>ee", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree" })
keymap("n", "<leader>ef", "<cmd>Neotree focus<cr>", { desc = "Focus Neotree" })
keymap("n", "<leader>er", "<cmd>Neotree reveal<cr>", { desc = "Reveal in Neotree" })

-- Copilot Chat
local chat = require("CopilotChat")
local select = require("CopilotChat.select")
keymap({ "n", "x" }, "<leader>cc", function()            -- Ask (auto-detect)
  chat.ask({}, { selection = select.visual or select.buffer })
end, { desc = "CopilotChat › Ask (uses visual selection or whole buffer)" })
keymap("n", "<leader>co",  ":CopilotChatOpen<CR>",   { desc = "Open chat window" })
keymap("n", "<leader>cq",  ":CopilotChatClose<CR>",  { desc = "Close chat window" })
keymap("n", "<leader>ct",  ":CopilotChatToggle<CR>", { desc = "Toggle chat window" })
keymap("n", "<leader>cs",  ":CopilotChatStop<CR>",   { desc = "Stop streaming answer" })
keymap("n", "<leader>cr",  ":CopilotChatReset<CR>",  { desc = "Reset/clear chat" })
keymap("n", "<leader>cm",  ":CopilotChatModels<CR>", { desc = "List available models" })
keymap("n", "<leader>ca",  ":CopilotChatAgents<CR>", { desc = "Choose agent" })
keymap({ "n", "x" }, "<leader>ce", function()
  chat.ask({ selection = select.visual or select.buffer }, { prompts = "Explain", window = "float" })
end, { desc = "Explain code (inline)" })
keymap({ "n", "x" }, "<leader>cf", ":CopilotChatInPlace Fix<CR>",
  { desc = "AI-fix selection/buffer in place" })

-- Bufferline
keymap("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
keymap("n", "<leader>bn", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
keymap("n", "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
keymap("n", "<leader>bd", "<cmd>BufferLinePickClose<cr>", { desc = "Pick buffer to close" })
