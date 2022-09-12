local util = require("formatter.util")

local pConf = function()
  return {
    exe = "prettier",
    args = {
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
      "--prose-wrap always",
    },
    stdin = true,
  }
end

local hclConf = function()
  return {
    exe = "terraform",
    args = { "fmt", "-" },
    stdin = true,
  }
end

local haskellConf = function()
  return {
    exe = "ormolu",
    args = {
      util.escape_path(util.get_current_buffer_file_path()),
    },
    stdin = true,
  }
end

local luaConf = function()
  return {
    exe = "stylua",
    args = {
      "--search-parent-directories",
      "--indent-type",
      "Spaces",
      "--indent-width",
      "2",
      "--stdin-filepath",
      util.escape_path(util.get_current_buffer_file_path()),
      "--",
      "-",
    },
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    javascript = { pConf },
    typescript = { pConf },
    yaml = { pConf },
    json = { pConf },
    jsonc = { pConf },
    css = { pConf },
    scss = { pConf },
    html = { pConf },
    yaml = { pConf },
    markdown = { pConf },
    typescriptreact = { pConf },
    ["markdown.mdx"] = { pConf },

    terraform = { hclConf },

    -- lua = { require("formatter.filetypes.lua").stylua },
    lua = { luaConf },

    haskell = { haskellConf },

    nix = {
      function()
        if vim.fn.executable("alejandra") == 1 then
          return {
            exe = "alejandra",
            stdin = true,
          }
        end
        return {
          exe = "nixpkgs-fmt",
          stdin = true,
        }
      end,
    },

    rust = {
      function()
        return {
          exe = "rustfmt",
          args = { "--emit=stdout" },
          stdin = true,
        }
      end,
    },

    -- clojure = {
    --   function()
    --     return {
    --       exe = "zprint",
    --       stdin = true}
    --   end},
  },
})

local group = vim.api.nvim_create_augroup("AutoFormat", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  group = group,
  command = "FormatWrite",
})
