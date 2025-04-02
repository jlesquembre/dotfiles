-- To find the logs path:
-- :lua print(vim.lsp.get_log_path())
-- vim.lsp.set_log_level('debug')

-- See:
-- https://rishabhrd.github.io/jekyll/update/2020/09/19/nvim_lsp_config.html

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = true,
  signs = false,
  update_in_insert = false,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

require("goto-preview").setup({ default_mappings = false })
local lspconfig = require("lspconfig")
local root_pattern = lspconfig.util.root_pattern

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

local function custom_attach(client, bufnr)
  local function set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = false }

  -- NEW in 0.10
  -- vim.lsp.inlay_hint.enable()

  set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)

  -- set_keymap('n', 'gdd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- set_keymap('n', 'gdi',   '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  set_keymap("n", "gdd", [[<cmd>lua require('goto-preview').goto_preview_definition()<CR>]], opts)
  set_keymap("n", "gdi", [[<cmd>lua require('goto-preview').goto_preview_implementation()<CR>]], opts)
  set_keymap("n", "gdc", [[<cmd>lua require('goto-preview').close_all_win()<CR>]], opts)
  -- set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  set_keymap("n", "gdg", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

  set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  set_keymap("n", "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)
  set_keymap("n", "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

  -- builtin: <c-w>d
  set_keymap("n", "<leader>dd", [[<cmd>lua vim.diagnostic.open_float({border = "single"})<CR>]], opts)

  set_keymap("n", "[d", [[<cmd>lua vim.diagnostic.goto_prev({float={border="single"}})<CR>]], opts)
  set_keymap("n", "]d", [[<cmd>lua vim.diagnostic.goto_next({float={border="single"}})<CR>]], opts)

  set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  set_keymap("n", "<leader>cl", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)

  -- set_keymap('n', 'gdp',  [[<cmd>lua peek_definition()<CR>]], opts)

  set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  -- set_keymap("v", "<leader>dc", [[<cmd>'<,'>lua require("telescope.builtin").lsp_code_action()<CR>]], opts)

  -- DAP
  set_keymap("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]], opts)
  set_keymap("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]], opts)
  set_keymap("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]], opts)
  set_keymap("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]], opts)
  set_keymap("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]], opts)
  set_keymap("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]], opts)
  set_keymap("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]], opts)

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

local function jdt_on_attach(client, bufnr)
  require("jdtls").setup_dap()
  custom_attach(client, bufnr)

  local function set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  local opts = { noremap = true, silent = true }

  set_keymap("n", "<leader>dc", '<cmd>lua require("jdtls").code_action()<CR>', opts)
  set_keymap("v", "<leader>dc", '<esc><cmd>lua require("jdtls").code_action(true)<CR>', opts)
  -- set_keymap('n', '<leader>rn', '<cmd>lua require("jdtls").code_action(false, "refactor")<CR>', opts)

  set_keymap("n", "<leader>di", '<Cmd>lua require"jdtls".organize_imports()<CR>', opts)
  set_keymap("n", "<leader>de", '<Cmd>lua require("jdtls").extract_variable()<CR>', opts)
  set_keymap("v", "<leader>de", '<Esc><Cmd>lua require("jdtls").extract_variable(true)<CR>', opts)
  set_keymap("v", "<leader>dm", '<Esc><Cmd>lua require("jdtls").extract_method(true)<CR>', opts)

  -- Run test mappings
  set_keymap("n", "cptt", '<Cmd>lua require"jdtls".test_nearest_method()<CR>', opts)
  set_keymap("n", "cpta", '<Cmd>lua require"jdtls".test_class()<CR>', opts)

  require("jdtls.setup").add_commands()
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local function setup_lspconfig()
  local default_config = { on_attach = custom_attach, capabilities = capabilities }
  local function extra_config(t)
    r = {}
    for k, v in pairs(default_config) do
      r[k] = v
    end
    for k, v in pairs(t) do
      r[k] = v
    end
    return r
  end

  -- web
  -- lspconfig.emmet_language_server.setup(extra_config({
  --   filetypes = {
  --     "css",
  --     "eruby",
  --     "html",
  --     "javascript",
  --     "javascriptreact",
  --     "less",
  --     "sass",
  --     "scss",
  --     "pug",
  --     "typescript",
  --     "typescriptreact",
  --   },
  -- }))

  lspconfig.emmet_language_server.setup(default_config)
  lspconfig.cssls.setup(default_config)
  lspconfig.html.setup(default_config)

  lspconfig.bashls.setup(default_config)
  lspconfig.clojure_lsp.setup(default_config)
  lspconfig.nickel_ls.setup(default_config)
  lspconfig.svelte.setup(default_config)
  lspconfig.vimls.setup(default_config)
  lspconfig.yamlls.setup(default_config)
  lspconfig.dockerls.setup(default_config)
  lspconfig.gopls.setup(default_config)
  lspconfig.pyright.setup(default_config)
  lspconfig.rust_analyzer.setup(default_config)
  lspconfig.nil_ls.setup(default_config)
  -- lspconfig.nixd.setup(default_config)
  lspconfig.terraformls.setup(default_config)
  lspconfig.clangd.setup(default_config)
  lspconfig.zls.setup(default_config)

  -- Special configs
  lspconfig.jsonls.setup(extra_config({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  }))
  lspconfig.ts_ls.setup(extra_config({
    root_dir = function(fname)
      return root_pattern("package.json", "tsconfig.json", ".git")(fname) or root_pattern(".")(fname)
    end,
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
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
      },
    },
  }
  local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf())
  local root_dir = root_pattern(".git", "gradlew", "mvnw", "pom.xml")(bufname)
  local workspace_dir = "/tmp/jdtls_workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local bundles = {
    "@java.debug.plugin@",
  }
  vim.list_extend(bundles, vim.split(vim.fn.glob("/home/jlle/tmp/vscode-java-test/server/*.jar"), "\n"))

  require("jdtls").start_or_attach({
    cmd = { "jdt-ls", "-data", workspace_dir },
    on_attach = jdt_on_attach,
    root_dir = root_dir,
    capabilities = capabilities,
    settings = settings,
    init_options = {
      bundles = bundles,
      extendedCapabilities = require("jdtls").extendedClientCapabilities,
    },
  })
end

vim.api.nvim_exec(
  [[
augroup LspCustom
  autocmd!
  autocmd FileType java lua start_jdtls()
augroup END
]],
  true
)

local M = {
  capabilities = capabilities,
  custom_attach = custom_attach,
}
return M
