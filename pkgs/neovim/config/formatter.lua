local conform = require("conform")
local notify = require("notify")

local markdown_formatter = vim.deepcopy(require("conform.formatters.prettier"))
require("conform.util").add_formatter_args(markdown_formatter, {
  "--prose-wrap",
  "always",
  "--print-width",
  "80",
}, { append = false })

---@cast markdown_formatter conform.FormatterConfigOverride
require("conform").formatters.prettier_markdown = markdown_formatter

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    starlark = { "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    ["markdown.mdx"] = { "prettier_markdown" },
    markdown = { "prettier_markdown" },
    css = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    yaml = { "prettier" },
    html = { "prettier" },
    graphql = { "prettier" },

    bzl = { "buildifier" },
    nix = { "nixfmt" },
    -- clojure = { "lsp_format" },
    -- clojure = { "cljfmt" },

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
    return { timeout_ms = 1000, lsp_format = "fallback" }
  end,
})

-- Run LSP commands before formatting a file
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format before save",
  pattern = { "*.clj", "*.cljs", "*.cljc", "*.edn", "*.bb" },
  group = vim.api.nvim_create_augroup("FormatConfig", { clear = true }),
  callback = function(ev)
    if vim.g.disable_autoformat or vim.b[ev.buf].disable_autoformat then
      return
    end

    -- Prevent LSP/Conform from running on scratch/unnamed/special buffers
    if vim.bo[ev.buf].buftype ~= "" or vim.api.nvim_buf_get_name(ev.buf) == "" then
      return
    end

    local client = vim.lsp.get_clients({ name = "clojure_lsp", bufnr = ev.buf })[1]

    if client then
      local request_result = client:request_sync("workspace/executeCommand", {
        command = "clean-ns",
        arguments = { vim.uri_from_bufnr(ev.buf), 0, 0 },
      })

      if request_result and request_result.err then
        vim.notify(request_result.err.message, vim.log.levels.ERROR)
        return
      end
    end

    require("conform").format({ bufnr = ev.buf, lsp_format = "first", timeout_ms = 2000 })
  end,
})

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
