-- lua/lsp/on_attach.lua
local M = {}

M.setup = function(client, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  local keymap = vim.keymap.set

  keymap("n", "<leader>gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to Declaration" }))
  keymap("n", "<leader>gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
  keymap("n", "<leader>K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
  keymap("n", "<leader>gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature Help" }))
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Action" }))
  keymap("n", "<leader>gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find References" }))

  local ignore = require("lsp.ignore_diagnostics")

  if client.name == "jdtls" then
    local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]

    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
      if not result then
        return
      end

      result.diagnostics = vim.tbl_filter(function(diagnostic)
        return not ignore.should_ignore(diagnostic.message)
      end, result.diagnostics)

      original_handler(_, result, ctx, config)
    end
  end
end

return M
