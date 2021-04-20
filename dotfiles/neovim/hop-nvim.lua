local set_keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false, expr = false}

set_keymap("n", "s"    , "<Nop>", {noremap = false})

set_keymap("n", "ss"    , "<cmd>lua require'hop'.hint_char1()<cr>", opts)
set_keymap("x", "ss"    , "<cmd>lua require'hop'.hint_char1()<cr>", opts)
set_keymap("o", "ss"    , "<cmd>lua require'hop'.hint_char1()<cr>", opts)

set_keymap("n", "sf"    , "<cmd>lua require'hop'.hint_char2()<cr>", opts)
set_keymap("x", "sf"    , "<cmd>lua require'hop'.hint_char2()<cr>", opts)
set_keymap("o", "sf"    , "<cmd>lua require'hop'.hint_char2()<cr>", opts)

set_keymap("n", "sw"    , "<cmd>lua require'hop'.hint_words()<cr>", opts)
set_keymap("x", "sw"    , "<cmd>lua require'hop'.hint_words()<cr>", opts)
set_keymap("o", "sw"    , "<cmd>lua require'hop'.hint_words()<cr>", opts)

set_keymap("n", "sl"    , "<cmd>lua require'hop'.hint_lines()<cr>", opts)
set_keymap("x", "sl"    , "<cmd>lua require'hop'.hint_lines()<cr>", opts)
set_keymap("o", "sl"    , "<cmd>lua require'hop'.hint_lines()<cr>", opts)

set_keymap("n", "s/"    , "<cmd>lua require'hop'.hint_patterns()<cr>", opts)
set_keymap("o", "s/"    , "<cmd>lua require'hop'.hint_patterns()<cr>", opts)
