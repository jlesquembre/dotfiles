vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 15

local cmp = require'cmp'

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
end

cmp.setup({
  -- snippet = {
  --   expand = function(args)
  --     vim.fn["vsnip#anonymous"](args.body)
  --   end,
  -- },
  -- mapping = {
  --   ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  -- },
  mapping = {
    -- ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        elseif check_back_space() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
        else
          fallback()
        end
      end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
  },
  formatting = {
    format = function(entry, vim_item)
      -- fancy icons and a name of kind
      vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
      -- set a name for each source
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        conjure = "[CLJ]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })[entry.source.name]
      return vim_item
    end,
  },
})

function _G.cmp_clojure_config()
  cmp.setup.buffer {
    sources = {
      { name = 'conjure' },
      { name = 'path' },
      { name = 'buffer' },
    },
  }
end

vim.api.nvim_exec([[
augroup CustomCmpMaps
  autocmd!
  autocmd FileType clojure lua cmp_clojure_config()
augroup END
]], true)

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})


-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--   documentation = true;

--   source = {
--     path = true;
--     buffer = true;
--     calc = false;
--     vsnip = false;
--     conjure = true;
--     nvim_lsp = { ignored_filetypes = {'clojure'} };
--     nvim_lua = true;
--     spell = true;
--     tags = true;
--     snippets_nvim = true;
--     treesitter = false;
--   };
-- }


-- local set_keymap = vim.api.nvim_set_keymap
-- local opts = {noremap = true, silent = true, expr = true}

-- -- set_keymap("i", "<C-Space>", "compe#complete()", opts)
-- -- See completion_confirm, combines nvim-compe and nvim-autopairs
-- -- set_keymap("i", "<CR>"     , "compe#confirm('<CR>')", opts)
-- set_keymap("i", "<C-e>"    , "compe#close('<C-e>')", opts)

-- -- Helper functions from the nvim-compe README
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

-- local check_back_space = function()
--     local col = vim.fn.col('.') - 1
--     if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--         return true
--     else
--         return false
--     end
-- end

-- --  Use (s-)tab to:
-- --- move to prev/next item in completion menuone
-- --- jump to prev/next snippet's placeholder

-- local snippets = require'snippets'

-- _G.tab_complete = function()
--   -- local pum_selected = vim.fn.complete_info()["selected"] ~= -1

--   if snippets.has_active_snippet() then
--     return t "<cmd>lua require'snippets'.advance_snippet(1)<CR>"
--   elseif vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end

-- _G.s_tab_complete = function()
--   if snippets.has_active_snippet() then
--     return t "<cmd>lua require'snippets'.advance_snippet(-1)<CR>"
--   elseif vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   else
--     return t "<S-Tab>"
--   end
-- end

-- local opts2 = {silent = true, expr = true, noremap = false}
-- set_keymap("i", "<Tab>", "v:lua.tab_complete()", opts2)
-- set_keymap("s", "<Tab>", "v:lua.tab_complete()", opts2)
-- set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", opts2)
-- set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts2)


-- local npairs = require('nvim-autopairs')

-- _G.MUtils= {}

-- vim.g.completion_confirm_key = ""
-- MUtils.completion_confirm = function()
--   if vim.fn.pumvisible() ~= 0  then
--     if vim.fn.complete_info()["selected"] ~= -1 then
--       return vim.fn["compe#confirm"](npairs.esc("<cr>"))
--     else
--       return npairs.esc("<cr>")
--     end
--   else
--     return npairs.autopairs_cr()
--   end
-- end

-- set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', opts)
