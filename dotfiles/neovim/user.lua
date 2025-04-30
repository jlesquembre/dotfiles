-- To test/hack stuff without a rebuild
-- luafile ~/.config/nvim/lua/user.lua
-- lua require('plenary.reload').reload_module('user')

-- local M =  {}

-- function M.add(a,b)
--    print(a+b)
-- end

-- return M

function _G.dump(...)
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

local colorscheme = require("base16-colorscheme")

local function custom_colors(color_name)
  colorscheme.setup(color_name)
  local c = colorscheme.colorschemes[color_name]
  local hi = colorscheme.highlight
  local bg = "#080808" -- From moonfly colors
  local fg = "#d8d8d8"

  hi.Normal = { guibg = bg }
  hi.Error = { guifg = bg }
  hi.ErrorMsg = { guibg = bg }
  hi.Conceal = { guibg = "none" }
  hi.Cursor = { guibg = bg }

  hi.MatchParen = { guifg = c.base05, guibg = c.base03, gui = "bold,italic" }

  hi.CursorLineSign = { guibg = c.base03 }
  hi.LineNr = { guifg = c.base03, guibg = c.base01 }
  hi.SignColumn = { guibg = c.base01 }
  hi.CursorLineNr = { guifg = c.base05, guibg = c.base03, gui = "bold" }
  hi.QuickFixLine = { guifg = c.base00, guibg = c.base09, gui = "none" }
  hi.PMenu = { guifg = c.base04, guibg = c.base02, gui = "none" }
  hi.PMenuSel = { guifg = c.base01, guibg = c.base04 }

  hi.NormalFloat = { guibg = c.base01 }

  hi.Reverse = { gui = "reverse" }
  hi.OnSelect = { guifg = "none", guibg = "#fff36d" }

  hi.DiffLine = { guifg = c.base03 }
  hi.DiffAdd = { guifg = "none", guibg = "#3b4229" }
  hi.DiffChange = { guifg = "none", guibg = "#2f4047" }
  hi.DiffDelete = { guifg = c.base08, guifg = c.base00 }
  hi.DiffText = { guifg = "none", guibg = "#461e1c" }

  hi.GitSignsAdd = { guifg = c.base0B }
  hi.GitSignsChange = { guifg = c.base0D }
  hi.GitSignsChangeDelete = { guifg = c.base0D }
  hi.GitSignsDelete = { guifg = c.base08 }
  -- hi.GitSignsAddCul = { guifg = c.base0B, guibg = c.base03 }
  -- hi.GitSignsChangeCul = { guifg = c.base0D, guibg = c.base03 }
  -- hi.GitSignsChangeDeleteCul = { guifg = c.base0D, guibg = c.base03 }
  -- hi.GitSignsDeleteCul = { guifg = c.base08, guibg = c.base03 }

  -- hi.LspReferenceRead  = { guibg = c.base02 }
  -- hi.LspReferenceWrite = { guibg = c.base02 }
  -- hi.LspReferenceText  = { guibg = c.base02 }
  hi.typescriptParens = { guibg = "none" }
  hi.BqfPreviewCursor = { guibg = c.base0A, guifg = c.base01 }
  hi.BqfPreviewRange = { guibg = c.base0A, guifg = c.base01 }

  hi.TelescopeBorder = { guifg = fg }
  hi.TelescopeResultsTitle = { guifg = bg, guibg = c.base0D }
  hi.TelescopePromptBorder = { guibg = c.base00, guifg = fg }
  hi.TelescopePromptPrefix = { guibg = c.base00, guifg = c.base0A }
  hi.TelescopePromptTitle = { guifg = c.base00, guibg = c.base0A }
  hi.TelescopePromptCounter = { guibg = c.base00, guifg = c.base0A }

  hi.RED = { guibg = c.base08, guifg = c.base00 }
  hi.GREEN = { guibg = c.base0B, guifg = c.base00 }

  -- Reset Telescope options
  -- vim.cmd [[highlight! link TelescopeSelection    Visual]]
  -- vim.cmd [[highlight! link TelescopeNormal       Normal]]
  -- vim.cmd [[highlight! link TelescopePromptNormal TelescopeNormal]]
  -- vim.cmd [[highlight! link TelescopeBorder       TelescopeNormal]]
  -- vim.cmd [[highlight! link TelescopePromptBorder TelescopeBorder]]
  -- vim.cmd [[highlight! link TelescopeTitle        TelescopeBorder]]
  -- vim.cmd [[highlight! link TelescopePromptTitle  TelescopeTitle]]
  -- vim.cmd [[highlight! link TelescopeResultsTitle TelescopeTitle]]
  -- vim.cmd [[highlight! link TelescopePreviewTitle TelescopeTitle]]
  -- vim.cmd [[highlight! link TelescopePromptPrefix Identifier]]
end

custom_colors("default-dark")

vim.api.nvim_exec(
  [[
augroup CustomActions
  autocmd!
  autocmd BufRead,BufNewFile Tiltfile setfiletype bzl
  " autocmd FileType TelescopePrompt inoremap <buffer> <esc> <cmd>lua require('telescope.actions').close(vim.api.nvim_get_current_buf())<cr>
  autocmd BufNewFile,BufRead *.mdx set filetype=markdown.mdx
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Reverse", timeout=350}
augroup END
]],
  true
)

require("nterm.main").init()
vim.keymap.set("t", "<C-e>", [[<cmd>lua require'nterm.main'.term_toggle()<cr>]], { remap = false })

local lisp_langs = require("jlle.conjure").lisp_langs

require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", unpack(lisp_langs) },
})

vim.g.rainbow_delimiters = {
  whitelist = lisp_langs,
}

function _G.toggle_qf()
  local qf_exists = false

  for _, win_id in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    for _, win in pairs(vim.fn.getwininfo(win_id)) do
      if win["quickfix"] == 1 then
        qf_exists = true
      end
    end
  end
  if qf_exists == true then
    vim.cmd("cclose")
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd("copen")
  else
    require("nterm.ui").popup("QuickFix empty!", { hl = "NtermError", pos = "NW" })
  end
end

function _G.new_scratch()
  local c = vim.api.nvim_command
  c("12new Scratch")

  vim.bo.bufhidden = "hide"
  vim.bo.buflisted = false
  vim.bo.buftype = "nofile"
  vim.bo.swapfile = false
  vim.wo.foldcolumn = "0"
  vim.wo.foldenable = false
  vim.wo.number = false
  vim.wo.winfixheight = true
  vim.wo.winfixwidth = true
end

vim.keymap.set("n", "<leader>es", "<cmd>lua new_scratch()<cr>", { remap = false, silent = false })

vim.keymap.set("n", "<leader>x", "<cmd>lua toggle_qf()<cr>", { remap = false, silent = false })

require("package-info").setup({ package_manager = "npm" })
vim.api.nvim_exec(
  [[
augroup NpmPackage
  autocmd!
  autocmd BufRead,BufNewFile package.json nnoremap <leader>np <cmd>lua require('package-info').change_version()<CR>
  autocmd BufRead,BufNewFile package.json nnoremap <leader>ni <cmd>lua require('package-info').install()<CR>
augroup END
]],
  true
)

require("snacks").setup()
require("snacks.picker").setup({
  ui_select = true,
  win = {
    input = {
      keys = {
        ["<Esc>"] = { "close", mode = { "n", "i" } },
      },
    },
  },
})
