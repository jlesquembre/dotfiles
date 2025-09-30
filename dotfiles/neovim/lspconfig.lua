-- To find the logs path:
-- :lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level('debug')

vim.diagnostic.config({
  virtual_text = true,
  -- virtual_lines = { current_line = true },
  underline = true,
  signs = false,
  update_in_insert = false,
})

require("goto-preview").setup({ default_mappings = false })

local function preview_location_callback(_, method, result)
  if result == nil or vim.tbl_isempty(result) then
    vim.lsp.log.info(method, "No location found")
    return nil
  end
  if vim.tbl_islist(result) then
    vim.lsp.util.preview_location(result[1], { border = "single" })
  else
    vim.lsp.util.preview_location(result, { border = "single" })
  end
end

function _G.peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, "textDocument/definition", params, preview_location_callback)
end

local function custom_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  local bufnr = ev.buf

  local function set_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { remap = false, silent = false, buffer = bufnr })
  end

  -- NEW in 0.10
  vim.lsp.inlay_hint.enable()

  set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>")

  set_keymap("n", "K", function()
    vim.lsp.buf.hover({
      border = "rounded",
    })
  end)

  -- set_keymap('n', 'gdd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- set_keymap('n', 'gdi',   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap("n", "gdd", [[<cmd>lua require('goto-preview').goto_preview_definition()<CR>]])
  set_keymap("n", "gdi", [[<cmd>lua require('goto-preview').goto_preview_implementation()<CR>]])
  set_keymap("n", "gdc", [[<cmd>lua require('goto-preview').close_all_win()<CR>]])
  -- set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap("n", "gdg", "<cmd>lua vim.lsp.buf.definition()<CR>")
  set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>")
  set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>")

  -- builtin: <c-w>d
  set_keymap("n", "<leader>dd", [[<cmd>lua vim.diagnostic.open_float({border = "single"})<CR>]])

  set_keymap("n", "[d", [[<cmd>lua vim.diagnostic.goto_prev({float={border="single"}})<CR>]])
  set_keymap("n", "]d", [[<cmd>lua vim.diagnostic.goto_next({float={border="single"}})<CR>]])

  set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  set_keymap("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>")

  -- set_keymap('n', 'gdp',  [[<cmd>lua peek_definition()<CR>]])

  set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  -- set_keymap("v", "<leader>dc", [[<cmd>'<,'>lua require("telescope.builtin").lsp_code_action()<CR>]], opts)

  -- DAP
  set_keymap("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
  set_keymap("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
  set_keymap("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
  set_keymap("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
  set_keymap("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
  set_keymap("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
  set_keymap("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])

  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

vim.api.nvim_create_autocmd("LspAttach", { callback = custom_attach })

vim.lsp.config.jsonls = {
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
    },
  },
}

vim.lsp.enable({
  -- "emmet_language_server",
  "jsonls",
  "ts_ls",
  "cssls",
  "html",
  "bashls",
  "clojure_lsp",
  "nickel_ls",
  "svelte",
  "vimls",
  "yamlls",
  "dockerls",
  "gopls",
  "pyright",
  "rust_analyzer",
  "nil_ls",
  "terraformls",
  "clangd",
  "zls",
})
