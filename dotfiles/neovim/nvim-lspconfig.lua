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

local function custom_attach(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  -- set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

  set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  set_keymap('n', 'gD',    '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  set_keymap('n', '1gD',   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  set_keymap('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  set_keymap('n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  set_keymap('n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

  -- set_keymap('n', '[w', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- set_keymap('n', ']w', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)


  -- set_keymap('n', '<leader>rn',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- set_keymap('n', '<leader>dc',  '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

  --
  -- LSPSAGA
  --
  set_keymap('n', 'K', [[<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], opts)
  set_keymap('n', '<C-f>', [[<cmd>lua require('lspsaga.hover').smart_scroll_hover(1)<CR>]], opts)
  set_keymap('n', '<C-b>', [[<cmd>lua require('lspsaga.hover').smart_scroll_hover(-1)<CR>]], opts)
  set_keymap('n', '<leader>ds',  [[<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]], opts)

  set_keymap('n', '<leader>gd',  [[<cmd>lua require'lspsaga.provider'.preview_definition()<CR>]], opts)
  set_keymap('n', '<leader>dd',  [[<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>]], opts)

  set_keymap('n', 'gh', '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', opts)
  set_keymap('n', '[w', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_prev()<CR>', opts)
  set_keymap('n', ']w', '<cmd>lua require"lspsaga.diagnostic".lsp_jump_diagnostic_next()<CR>', opts)


  set_keymap('n', '<leader>rn',  [[<cmd>lua require('lspsaga.rename').rename()<CR>]], opts)
  set_keymap('n', '<leader>dc',  [[<cmd>lua require("lspsaga.codeaction").code_action()<CR>]], opts)
  set_keymap('v', '<leader>dc',  [[<cmd>'<,'>lua require("lspsaga.codeaction").code_action()<CR>]], opts)
  --
  -- END LSPSAGA
  --


  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup lsp_document_highlight
        autocmd!
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

local function jdt_on_attach(client, bufnr)
  custom_attach(client, bufnr)
  local function set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = {noremap = true, silent = true}

  set_keymap('n', '<leader>dc', '<cmd>lua require("jdtls").code_action()<CR>', opts)
  set_keymap('v', '<leader>dc', '<esc><cmd>lua require("jdtls").code_action(true)<CR>', opts)
  -- set_keymap('n', '<leader>rn', '<cmd>lua require("jdtls").code_action(false, "refactor")<CR>', opts)

  set_keymap('n', '<leader>di', '<Cmd>lua require"jdtls".organize_imports()<CR>', opts)
  set_keymap('n', '<leader>de', '<Cmd>lua require("jdtls").extract_variable()<CR>', opts)
  set_keymap('v', '<leader>de', '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>', opts)
  set_keymap('v', '<leader>dm', '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>', opts)

  require('jdtls.setup').add_commands()

  vim.api.nvim_exec([[
    augroup FormatLspAutogroup
      autocmd!
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
    augroup END
  ]], false)
end


local function setup_lspconfig()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local default_config = {on_attach = custom_attach,
                          capabilities = capabilities}
  local function extra_config(t)
    r = {}
    for k,v in pairs(default_config) do r[k] = v end
    for k,v in pairs(t) do r[k] = v end
    return r
  end

  lspconfig.bashls.setup(default_config)
  lspconfig.clojure_lsp.setup(default_config)
  lspconfig.cssls.setup(default_config)
  lspconfig.html.setup(default_config)
  lspconfig.svelte.setup(default_config)
  lspconfig.vimls.setup(default_config)
  lspconfig.yamlls.setup(default_config)
  lspconfig.dockerls.setup(default_config)
  lspconfig.gopls.setup(default_config)
  -- require'lspconfig'.jdtls.setup(default_config)
  lspconfig.jsonls.setup(default_config)
  lspconfig.rls.setup(default_config)
  -- require'lspconfig'.rnix.setup(default_config)
  lspconfig.terraformls.setup(default_config)

  -- Special configs
  lspconfig.tsserver.setup(extra_config(
                           {root_dir = function(fname)
                                         return root_pattern("package.json", "tsconfig.json", ".git")(fname) or
                                                root_pattern(".")(fname)
                                       end;
                           }))
end

setup_lspconfig()


function start_jdtls()
  local settings = {
    java = {
      signatureHelp = { enabled = true },
      referenceCodeLens = { enabled = true },
      implementationsCodeLens = { enabled = true },
      autobuild = { enabled = true },
      trace = { server = "verbose" },
      -- contentProvider = { preferred = 'fernflower' };
      -- completion = {
      --   favoriteStaticMembers = {
      --     "org.hamcrest.MatcherAssert.assertThat",
      --     "org.hamcrest.Matchers.*",
      --     "org.hamcrest.CoreMatchers.*",
      --     "org.junit.jupiter.api.Assertions.*",
      --     "java.util.Objects.requireNonNull",
      --     "java.util.Objects.requireNonNullElse",
      --     "org.mockito.Mockito.*"
      --   }
      -- },
      sources = {
        organizeImports = {
          starThreshold = 9999;
          staticStarThreshold = 9999;
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      },
    },
  }
  local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local root_dir = root_pattern('.git', 'gradlew', 'mvnw', 'pom.xml')(bufname)
  local workspace_dir = "/tmp/jdtls_workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  require('jdtls').start_or_attach({
      cmd = {'jdt-ls', '-data', workspace_dir},
      on_attach = jdt_on_attach,
      root_dir = root_dir,
      capabilities = capabilities,
      settings = settings,
      init_options = {
          extendedCapabilities = require('jdtls').extendedClientCapabilities,
        },
      })
end

vim.api.nvim_exec([[
augroup LspCustom
  autocmd!
  autocmd FileType java lua start_jdtls()
augroup END
]], true)

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

local saga = require 'lspsaga'
saga.init_lsp_saga()


vim.lsp.handlers["textDocument/hover"] = require('lspsaga.hover').handler
