local api = vim.api

local metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
  useGlobalExecutable = true,
}
metals_config.init_options.statusBarProvider = "on"

local my_lspconfig = require("jlle.lspconfig")
metals_config.capabilities = require("cmp_nvim_lsp").update_capabilities(my_lspconfig.capabilities)

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  api.nvim_set_keymap(mode, lhs, rhs, options)
end

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()

  my_lspconfig.custom_attach(client, bufnr)

  map("n", "cpp", [[<cmd>lua require("metals").hover_worksheet({ border = "single" })<CR>]])
  map("n", "ctt", [[<cmd>lua require("metals.tvp").toggle_tree_view()<CR>]])
  map("n", "ctr", [[<cmd>lua require("metals.tvp").reveal_in_tree()<CR>]])
  map("n", "cst", [[<cmd>lua require("metals").toggle_setting("showImplicitArguments")<CR>]])

  map("n", "<leader>m", [[<cmd>lua require("telescope").extensions.metals.commands()<CR>]])
end

local nvim_metals_group = api.nvim_create_augroup("nvim-metals", { clear = true })
api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

local dap = require("dap")
dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
}
