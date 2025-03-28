-- lua/lsp/on_attach.lua
local M = {}

M.setup = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local keymap = vim.keymap.set

  keymap('n', 'gD', vim.lsp.buf.declaration, opts)
  keymap('n', 'gd', vim.lsp.buf.definition, opts)
  keymap('n', 'K', vim.lsp.buf.hover, opts)
  keymap('n', 'gi', vim.lsp.buf.implementation, opts)
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  keymap('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  keymap('n', 'gr', vim.lsp.buf.references, opts)

  local ignore = require("lsp.ignore_diagnostics")

  if client.name == "jdtls" then
    local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if not result then return end

      result.diagnostics = vim.tbl_filter(function(diagnostic)
        return not ignore.should_ignore(diagnostic.message)
      end, result.diagnostics)

      original_handler(_, result, ctx, config)
    end
  end
end

return M
