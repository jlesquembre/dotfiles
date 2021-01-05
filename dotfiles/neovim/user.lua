vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = false,
    update_in_insert = false,
})

-- To test/hack stuff without a rebuild

-- local M =  {}

-- function M.add(a,b)
--    print(a+b)
-- end

-- return M
