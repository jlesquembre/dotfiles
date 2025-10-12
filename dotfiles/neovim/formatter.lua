local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    markdown = { "prettier" },
    css = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    html = { "prettier" },
    graphql = { "prettier" },

    bzl = { "buildifier" },
    nix = { "nixfmt" },

    -- Use the "*" filetype to run formatters on all filetypes.
    -- ["*"] = { "codespell" },

    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },

  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    -- These options will be passed to conform.format()
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
})

local notify = require("notify")

vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    -- FormatToggle! will toggle formatting just for this buffer
    vim.b.disable_autoformat = not vim.b.disable_autoformat
  else
    vim.g.disable_autoformat = not vim.g.disable_autoformat
  end

  local msg = string.format(
    "Auto format GLOBAL -> %s\nAuto format BUFFER -> %s",
    (vim.g.disable_autoformat and "OFF (ignores buffer)" or "ON"),
    (vim.b.disable_autoformat and "OFF" or "ON")
  )
  notify(msg, "info", { render = "minimal" })
end, {
  desc = "Toggle autoformat-on-save",
  bang = true,
})
