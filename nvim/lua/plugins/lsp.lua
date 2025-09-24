return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- This function runs for each LSP server attached
    local on_attach = function(client, bufnr)
      -- ... (no changes here in the on_attach function)
      local keymap = vim.keymap.set
      local opts = { noremap = true, silent = true, buffer = bufnr }

      keymap('n', 'gd', vim.lsp.buf.definition, opts)
      keymap('n', 'K', vim.lsp.buf.hover, opts)
      keymap('n', 'gi', vim.lsp.buf.implementation, opts)
      keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
      keymap('n', '<leader>rn', vim.lsp.buf.rename, opts)
      keymap({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
      keymap('n', 'gr', vim.lsp.buf.references, opts)
      keymap('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
      keymap('n', '<leader>d', vim.diagnostic.open_float, opts)
    end

    local servers = { "pyright", "ruff", "lua_ls" }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = servers,
    })

    local lspconfig = require("lspconfig")

    for _, server in ipairs(servers) do
      if server == "lua_ls" then
        lspconfig[server].setup({
          on_attach = on_attach,
          settings = {
            Lua = { diagnostics = { globals = { "vim" } } },
          },
        })
      else
        lspconfig[server].setup({
          on_attach = on_attach,
        })
      end
    end

    vim.diagnostic.config({
      float = { border = "rounded" },
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, { border = "rounded" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, { border = "rounded" }
    )
  end,
}
