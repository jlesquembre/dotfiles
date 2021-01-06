-- To find the logs path:
-- :lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level('debug')

-- See:
-- https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = true,
    signs = false,
    update_in_insert = false,
})


local lspconfig = require'lspconfig'
local root_pattern = lspconfig.util.root_pattern

local function custom_attach()
  local bufnr = 0
  local set_keymap = vim.api.nvim_buf_set_keymap
  local opts = {noremap = true, silent = true}

  set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

  set_keymap(bufnr, 'n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap(bufnr, 'n', 'gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap(bufnr, 'n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap(bufnr, 'n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  set_keymap(bufnr, 'n', '1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set_keymap(bufnr, 'n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  set_keymap(bufnr, 'n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  set_keymap(bufnr, 'n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

  set_keymap(bufnr, 'n', '[w', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  set_keymap(bufnr, 'n', ']w', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  set_keymap(bufnr, 'n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  set_keymap(bufnr, 'n', '<leader>dc',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
-- " vim.lsp.buf.formatting()
-- " vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
end


lspconfig.bashls.setup{on_attach = custom_attach}
lspconfig.clojure_lsp.setup{on_attach = custom_attach}
lspconfig.cssls.setup{on_attach = custom_attach}
lspconfig.tsserver.setup{on_attach=custom_attach,
                         root_dir=root_pattern("package.json", "tsconfig.json", ".git", ".")}
lspconfig.vimls.setup{on_attach = custom_attach}
lspconfig.yamlls.setup{on_attach = custom_attach}
lspconfig.dockerls.setup{on_attach = custom_attach}
lspconfig.gopls.setup{on_attach = custom_attach}
lspconfig.html.setup{on_attach = custom_attach}
-- require'lspconfig'.jdtls.setup{}
lspconfig.jsonls.setup{on_attach = custom_attach}
lspconfig.rls.setup{on_attach = custom_attach}
-- require'lspconfig'.rnix.setup{}
lspconfig.terraformls.setup{on_attach = custom_attach}


-- java lsp
-- local finders = require'telescope.finders'
-- local sorters = require'telescope.sorters'
-- local actions = require'telescope.actions'
-- function(items, prompt, label_fn, cb)
--   local opts = {}
--   pickers.new(opts, {
--     prompt_title = prompt,
--     finder    = finders.new_table {
--       results = items,
--       entry_maker = function(entry)
--         return {
--           value = entry,
--           display = label_fn(entry),
--           ordinal = label_fn(entry),
--         }
--       end,
--     },
--     sorter = sorters.get_generic_fuzzy_sorter(),
--     attach_mappings = function(prompt_bufnr)
--       actions.goto_file_selection_edit:replace(function()
--         local selection = actions.get_selected_entry(prompt_bufnr)
--         actions.close(prompt_bufnr)

--         cb(selection.value)
--       end)

--       return true
--     end,
--   }):find()


-- Completion and so on

-- TODO
-- maps to add

-- local call = vim.api.nvim_call_function

-- function tab_complete()
--     if vim.fn.pumvisible() == 1 then
--         return rt('<C-N>')
--     elseif call('vsnip#available', {1}) == 1 then
--         return rt('<Plug>(vsnip-expand-or-jump)')
--     else
--         return rt('<Tab>')
--     end
-- end

-- function s_tab_complete()
--     if vim.fn.pumvisible() == 1 then
--         return rt('<C-P>')
--     elseif call('vsnip#jumpable', {-1}) == 1 then
--         return rt('<Plug>(vsnip-jump-prev)')
--     else
--         return rt('<S-Tab>')
--     end
-- end

-- Help
-- function K_help()
--   if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
--     vim.api.nvim_command('normal! K')
--   else
--     vim.lsp.buf.hover()
--   end
-- end
-- And the mapping of those is :

-- imap <expr><TAB> v:lua.tab_complete()
-- smap <expr><TAB> v:lua.tab_complete()

-- imap <expr><S-TAB> v:lua.s_tab_complete()
-- smap <expr><S-TAB> v:lua.s_tab_complete()

-- vim.api.nvim_set_keymap('n', 'K', ':lua K_help()<cr>', { noremap = true, silent = true })
