-- To find the logs path:
-- :lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level('debug')

-- See:
-- https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html

local root_pattern = require'lspconfig'.util.root_pattern

require'lspconfig'.bashls.setup{}
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.tsserver.setup{root_dir = root_pattern("package.json", "tsconfig.json", ".git", ".")}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.rls.setup{}
-- require'lspconfig'.rnix.setup{}
require'lspconfig'.terraformls.setup{}


-- Completion and so on

-- TODO
-- maps to add
-- local rt = function(codes)
--     return vim.api.nvim_replace_termcodes(codes, true, true, true)
-- end

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

-- -- Help
-- function K_help_hover()
--   if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
--     return "K"
--   else
--     return rt("<cmd>lua vim.lsp.buf.hover()<CR>")
--   end
-- end

-- And the mapping of those is :

-- imap <expr><TAB> v:lua.tab_complete()
-- smap <expr><TAB> v:lua.tab_complete()

-- imap <expr><S-TAB> v:lua.s_tab_complete()
-- smap <expr><S-TAB> v:lua.s_tab_complete()

-- nnoremap <expr>K v:lua.K_help_hover()
