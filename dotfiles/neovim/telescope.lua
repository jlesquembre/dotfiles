local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')

require('telescope').setup{
  defaults = {
    file_sorter = sorters.get_fzy_sorter,

    file_previewer   = previewers.vim_buffer_cat.new,
    grep_previewer   = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-s>"] = actions.send_to_qflist,
        -- ["<cr>"] = actions.goto_file_selection_split,
      },
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    -- TODO fix it
    -- Usage:
    -- :Telescope lispdocs
    -- lispdocs = {
    --   mappings = {
    --     i = {
    --       ["<cr>"] = actions.goto_file_selection_split,
    --     },
    --   },
    -- },
  },
}

local M = {}
M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<c-r>', actions.git_delete_branch)
      map('n', '<c-r>', actions.git_delete_branch)
      return true
    end
  })
end

-- Falling back to find_files if git_files can't find a .git directory
M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('lispdocs')
require('telescope').load_extension('nterm')


local set_keymap = function(mod, lhs, rhs, module)
  local opts = {noremap = true, silent = false}
  vim.api.nvim_set_keymap(mod, lhs, "<cmd>lua require('".. module .."')."..  rhs .. "<cr>", opts)
end

set_keymap("n", "<leader>ff",   "project_files()", "jlle.telescope")
set_keymap("n", "<leader>fe",   "file_browser()", "telescope.builtin")
set_keymap("n", "<leader>fs",   "live_grep()", "telescope.builtin")
set_keymap("n", "<leader>fo",   "oldfiles()", "telescope.builtin")
set_keymap("n", "<leader><cr>", "buffers()", "telescope.builtin")
set_keymap("n", "<leader>fh",   "help_tags()", "telescope.builtin")

set_keymap("n", "<leader>fa", "builtin()", "telescope.builtin")
set_keymap("n", "<leader>fq", "quickfix()", "telescope.builtin")
set_keymap("n", "<leader>fm", "keymaps()", "telescope.builtin")

set_keymap("n", "<leader>fgg", "git_status()", "telescope.builtin")
set_keymap("n", "<leader>fgb", "git_branches()", "jlle.telescope")
set_keymap("n", "<leader>fga", "git_commits()", "telescope.builtin")
set_keymap("n", "<leader>fgc", "git_bcommits()", "telescope.builtin")

set_keymap("n", "<leader>ft",   "extensions.nterm.nterm()", "telescope")

return M
