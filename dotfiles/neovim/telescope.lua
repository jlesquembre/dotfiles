local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local previewers = require("telescope.previewers")
local lga_actions = require("telescope-live-grep-args.actions")

require("telescope").setup({
  defaults = {

    preview = {
      treesitter = {
        enable = true,
        disable = { "lua", "vim" },
      },
    },
    -- layout_strategy = "bottom_pane",

    -- Default previewers
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-s>"] = actions.send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-f>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          ["<c-r>"] = actions.to_fuzzy_refine,
        },
      },
    },
  },
})

local M = {}
M.git_branches = function()
  require("telescope.builtin").git_branches({
    attach_mappings = function(prompt_bufnr, map)
      map("i", "<c-r>", actions.git_delete_branch)
      map("n", "<c-r>", actions.git_delete_branch)
      return true
    end,
  })
end

-- Falling back to find_files if git_files can't find a .git directory
M.project_files = function()
  local ok = pcall(require("telescope.builtin").git_files, { show_untracked = true })
  if not ok then
    require("telescope.builtin").find_files({})
  end
end

require("telescope").load_extension("nterm")

local set_keymap = function(mod, lhs, rhs, module)
  local opts = { noremap = true, silent = false }
  vim.api.nvim_set_keymap(mod, lhs, "<cmd>lua require('" .. module .. "')." .. rhs .. "<cr>", opts)
end

set_keymap("n", "<leader>ff", "project_files()", "jlle.telescope")
set_keymap("n", "<leader>fe", "file_browser()", "telescope.builtin")
-- set_keymap("n", "<leader>fs", "live_grep()", "telescope.builtin")
set_keymap("n", "<leader>fs", "extensions.live_grep_args.live_grep_args()", "telescope")
set_keymap("n", "<leader>fo", "oldfiles()", "telescope.builtin")
set_keymap("n", "<leader><cr>", "buffers()", "telescope.builtin")
set_keymap("n", "<leader>fh", "help_tags()", "telescope.builtin")

set_keymap("n", "<leader>fa", "builtin()", "telescope.builtin")
set_keymap("n", "<leader>fq", "quickfix()", "telescope.builtin")
set_keymap("n", "<leader>fm", "keymaps()", "telescope.builtin")

set_keymap("n", "<leader>fgg", "git_status()", "telescope.builtin")
set_keymap("n", "<leader>fgb", "git_branches()", "jlle.telescope")
set_keymap("n", "<leader>fga", "git_commits()", "telescope.builtin")
set_keymap("n", "<leader>fgc", "git_bcommits()", "telescope.builtin")

set_keymap("n", "<leader>ft", "extensions.nterm.nterm()", "telescope")

function help_ft_telescope()
  local bufnr = 0
  local set_keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }

  set_keymap(bufnr, "n", "<leader>fh", '<cmd>lua require"lispdocs".find()<cr>', {})
end

vim.api.nvim_exec(
  [[
augroup LispSettings
  autocmd!
  autocmd FileType lisp,clojure,scheme,fennel lua help_ft_telescope()
augroup END
]],
  true
)

require("telescope").load_extension("file_browser")

return M
