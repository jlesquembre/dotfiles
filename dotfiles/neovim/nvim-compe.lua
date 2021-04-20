vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 15

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = false;
    vsnip = false;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = false;
    conjure = true;
  };
}


local set_keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true, expr = true}

-- set_keymap("i", "<C-Space>", "compe#complete()", opts)
-- See completion_confirm, combines nvim-compe and nvim-autopairs
-- set_keymap("i", "<CR>"     , "compe#confirm('<CR>')", opts)
set_keymap("i", "<C-e>"    , "compe#close('<C-e>')", opts)

-- Helper functions from the nvim-compe README
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

--  Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder

local snippets = require'snippets'

_G.tab_complete = function()
  -- local pum_selected = vim.fn.complete_info()["selected"] ~= -1

  if snippets.has_active_snippet() then
    return t "<cmd>lua require'snippets'.advance_snippet(1)<CR>"
  elseif vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if snippets.has_active_snippet() then
    return t "<cmd>lua require'snippets'.advance_snippet(-1)<CR>"
  elseif vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

local opts2 = {silent = true, expr = true, noremap = false}
set_keymap("i", "<Tab>", "v:lua.tab_complete()", opts2)
set_keymap("s", "<Tab>", "v:lua.tab_complete()", opts2)
set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", opts2)
set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", opts2)


local npairs = require('nvim-autopairs')

_G.MUtils= {}

vim.g.completion_confirm_key = ""
MUtils.completion_confirm = function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      return vim.fn["compe#confirm"](npairs.esc("<c-r>"))
    else
      return npairs.esc("<cr>")
    end
  else
    return npairs.autopairs_cr()
  end
end

set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', opts)
