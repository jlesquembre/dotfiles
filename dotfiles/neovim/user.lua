-- To test/hack stuff without a rebuild
-- luafile ~/.config/nvim/lua/user.lua
-- lua require('plenary.reload').reload_module('user')

-- local M =  {}

-- function M.add(a,b)
--    print(a+b)
-- end

-- return M

require"toggleterm".setup{
  size = 20,
  open_mapping = [[<leader>tt]],
  shade_filetypes = {},
  shade_terminals = true,
  persist_size = true,
  direction = 'horizontal',
  -- direction = 'vertical' | 'horizontal'
}


local opts = {noremap = true, silent = false}
vim.api.nvim_set_keymap('n', '<leader>gp',
                        [[<cmd>lua require'toggleterm'.exec("git push", 10, 12)<cr>]], opts)

