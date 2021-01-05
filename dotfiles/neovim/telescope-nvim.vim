nnoremap <leader>ff <cmd>lua require('telescope.builtin').git_files()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fo <cmd>lua require('telescope.builtin').oldfiles()<cr>
nnoremap <leader><cr> <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

nnoremap <leader>fa <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap <leader>fq <cmd>lua require('telescope.builtin').quickfix()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').keymaps()<cr>

nnoremap <leader>fgg <cmd>lua require('telescope.builtin').git_status()<cr>
nnoremap <leader>fgb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>fga <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>fgc <cmd>lua require('telescope.builtin').git_bcommits()<cr>
" nnoremap <leader>dc <cmd>lua require('telescope.builtin').lsp_code_actions()<cr>
