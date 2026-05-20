require("nvim-treesitter.config").setup({
  additional_vim_regex_highlighting = false,
  -- Not needed, Nix manage the parsers
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ensure_installed = 'maintained',
  highlight = {
    enable = true,
    -- disable = { "nix", "markdown" },
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
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(event)
    local buf_name = vim.api.nvim_buf_get_name(event.buf)
    local file_size = vim.api.nvim_call_function("getfsize", {
      buf_name,
    })
    if file_size > 256 * 1024 then
      vim.notify("File size: " .. file_size .. ". Too big, treesitter disabled", vim.log.levels.WARN)
      return
    end

    local filetype = vim.api.nvim_get_option_value("filetype", {
      buf = event.buf,
    })

    local lang = vim.treesitter.language.get_lang(filetype)
    if not lang or not vim.treesitter.language.add(lang) then
      return
    end

    local success, err = pcall(vim.treesitter.start, event.buf, lang)
    if not success then
      vim.notify("Failed to start treesitter parser for [" .. lang .. "]: " .. err, vim.log.levels.WARN)
    end
  end,
})
