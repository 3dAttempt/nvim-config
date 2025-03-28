return {
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls' },
      }
    end,
  },
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java',
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require 'lspconfig'

      local on_attach = require('lsp.on_attach').setup
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities
      }
    end,
  },
}
