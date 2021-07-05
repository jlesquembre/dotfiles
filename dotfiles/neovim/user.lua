-- To test/hack stuff without a rebuild
-- luafile ~/.config/nvim/lua/user.lua
-- lua require('plenary.reload').reload_module('user')

-- local M =  {}

-- function M.add(a,b)
--    print(a+b)
-- end

-- return M

-- require"toggleterm".setup{
--   size = 20,
--   open_mapping = [[<c-t>]],
--   shade_filetypes = {},
--   shade_terminals = true,
--   persist_size = true,
--   direction = 'horizontal',
--   -- direction = 'vertical' | 'horizontal'
-- }


-- local opts = {noremap = true, silent = false}
-- vim.api.nvim_set_keymap('n', '<leader>gp',
--                         [[<cmd>lua require'toggleterm'.exec("git push", 10, 12)<cr>]], opts)

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, {...})
  print(unpack(objects))
end

local colorscheme = require('base16-colorscheme')

local function custom_colors(color_name)
  colorscheme.setup(color_name)
  local c = colorscheme.colorschemes[color_name]
  local hi = colorscheme.highlight
  local bg = "#080808" -- From moonfly colors

  hi.Normal   = { guibg = bg}
  hi.Error    = { guifg = bg}
  hi.ErrorMsg = { guibg = bg}
  hi.Conceal  = { guifg = bg}
  hi.Cursor   = { guibg = bg}

  hi.MatchParen = {guifg = c.base05, guibg = c.base03, gui = "bold,italic"}

  hi.LineNr       = { guifg = c.base03, guibg = c.base01 }
  hi.SignColumn   = { guibg = c.base01 }
  hi.CursorLineNr = { guifg = c.base05, guibg = c.base03, gui = "bold"}
  hi.QuickFixLine = { guifg = c.base00, guibg = c.base09, gui = "none"}
  hi.PMenu        = { guifg = c.base04, guibg = c.base01, gui = "none"}
  hi.PMenuSel     = { guifg = c.base01, guibg = c.base04 }
  hi.NormalFloat  = { guibg = c.base01 }

  hi.Reverse = { gui = "reverse" }

  hi.DiffLine   = { guifg = c.base03 }
  hi.DiffAdd    = { guifg = "none",   guibg = "#3b4229" }
  hi.DiffChange = { guifg = "none",   guibg = "#2f4047" }
  hi.DiffDelete = { guifg = c.base08, guifg = c.base00 }
  hi.DiffText   = { guifg = "none",   guibg = "#461e1c" }

  hi.GitSignsAdd          = { guifg = c.base0B, guibg = c.base01 }
  hi.GitSignsChange       = { guifg = c.base0D, guibg = c.base01 }
  hi.GitSignsChangeDelete = { guifg = c.base0D, guibg = c.base01 }
  hi.GitSignsDelete       = { guifg = c.base08, guibg = c.base01 }

  -- hi.LspReferenceRead  = { guibg = c.base02 }
  -- hi.LspReferenceWrite = { guibg = c.base02 }
  -- hi.LspReferenceText  = { guibg = c.base02 }
end

custom_colors('default-dark')


vim.api.nvim_exec([[
augroup CustomActions
  autocmd!
  autocmd BufRead,BufNewFile Tiltfile setfiletype bzl
  " autocmd FileType TelescopePrompt inoremap <buffer> <esc> <cmd>lua require('telescope.actions').close(vim.api.nvim_get_current_buf())<cr>
  autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Reverse", timeout=350}
augroup END
]], true)


require"nterm.main".init()

require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "clojure" },
})
