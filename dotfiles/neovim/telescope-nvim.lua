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
require('telescope').load_extension('fzy_native')
require('telescope').load_extension('lispdocs')
