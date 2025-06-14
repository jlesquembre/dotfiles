vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 15

local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

local check_back_space = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
      elseif check_back_space() then
        vim.fn.feedkeys(t("<Tab>"), "n")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "luasnip" },
    -- { name = "copilot", group_index = 2 },
    { name = "copilot" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
    { name = "buffer", keyword_length = 3 },
  },
  -- formatting = {
  --   format = function(entry, vim_item)
  --     -- fancy icons and a name of kind
  --     vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
  --     -- set a name for each source
  --     vim_item.menu = ({
  --       buffer = "[Buffer]",
  --       copilot = "",
  --       nvim_lsp = "[LSP]",
  --       conjure = "[CLJ]",
  --       luasnip = "[LuaSnip]",
  --       nvim_lua = "[Lua]",
  --       latex_symbols = "[Latex]",
  --     })[entry.source.name]
  --     return vim_item
  --   end,
  -- },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      max_width = 50,
      symbol_map = { Copilot = "" },
    }),
  },
})

function _G.cmp_clojure_config()
  cmp.setup.buffer({
    sources = {
      { name = "luasnip" },
      { name = "conjure" },
      { name = "path" },
      { name = "buffer", keyword_length = 3 },
    },
  })
end

vim.api.nvim_exec(
  [[
augroup CustomCmpMaps
  autocmd!
  autocmd FileType clojure lua cmp_clojure_config()
augroup END
]],
  true
)

-- vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
