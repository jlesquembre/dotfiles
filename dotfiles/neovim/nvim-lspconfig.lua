-- To find the logs path:
-- :lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level('debug')

require'lspconfig'.bashls.setup{}
require'lspconfig'.clojure_lsp.setup{}
require'lspconfig'.cssls.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.vimls.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.dockerls.setup{}
require'lspconfig'.gopls.setup{}
require'lspconfig'.html.setup{}
require'lspconfig'.jdtls.setup{}
require'lspconfig'.jsonls.setup{}
require'lspconfig'.rls.setup{}
require'lspconfig'.rnix.setup{}
require'lspconfig'.terraformls.setup{}
