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
        ["<c-q>"] = actions.send_to_qflist,
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
    -- lispdocs = {
    --   mappings = {
    --     i = {
    --       ["<cr>"] = actions.goto_file_selection_split,
    --     },
    --   },
    -- },
  },
}

-- TODO this should be a real module
local git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<c-r>', actions.git_delete_branch)
      map('n', '<c-r>', actions.git_delete_branch)
      return true
    end
  })
end

require('telescope').load_extension('fzy_native')
require('telescope').load_extension('lispdocs')


local set_keymap = function(mod, lhs, rhs)
  local opts = {noremap = true, silent = false}
  vim.api.nvim_set_keymap(mod, lhs, "<cmd>lua require('telescope.builtin')."..  rhs .. "<cr>", opts)
end

set_keymap("n", "<leader>ff",   "git_files()")
set_keymap("n", "<leader>fs",   "live_grep()")
set_keymap("n", "<leader>fo",   "oldfiles()")
set_keymap("n", "<leader><cr>", "buffers()")
set_keymap("n", "<leader>fh",   "help_tags()")

set_keymap("n", "<leader>fa", "builtin()")
set_keymap("n", "<leader>fq", "quickfix()")
set_keymap("n", "<leader>fm", "keymaps()")

set_keymap("n", "<leader>fgg", "git_status()")
set_keymap("n", "<leader>fgb", "git_branches()")
set_keymap("n", "<leader>fga", "git_commits()")
set_keymap("n", "<leader>fgc", "git_bcommits()")
