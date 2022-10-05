require("nvim-treesitter.configs").setup({
  -- Not needed, Nix manage the parsers
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = { "nix", "markdown" },
  },
  -- TODO better mappings
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
    disable = { "bash", "nix" }, -- please disable bash until I figure #1 out
  },
})
