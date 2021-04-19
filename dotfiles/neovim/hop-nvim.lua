local set_keymap = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false, expr = false}

set_keymap("n", "s"    , "<Nop>", {noremap = false})

set_keymap("n", "ss"    , "<cmd>HopChar1<cr>", opts)
set_keymap("x", "ss"    , "<cmd>HopChar1<cr>", opts)
set_keymap("o", "ss"    , "<cmd>HopChar1<cr>", opts)

set_keymap("n", "sf"    , "<cmd>HopChar2<cr>", opts)
set_keymap("x", "sf"    , "<cmd>HopChar2<cr>", opts)
set_keymap("o", "sf"    , "<cmd>HopChar2<cr>", opts)

set_keymap("n", "sw"    , "<cmd>HopWord<cr>", opts)
set_keymap("x", "sw"    , "<cmd>HopWord<cr>", opts)
set_keymap("o", "sw"    , "<cmd>HopWord<cr>", opts)

set_keymap("n", "sl"    , "<cmd>HopLine<cr>", opts)
set_keymap("x", "sl"    , "<cmd>HopLine<cr>", opts)
set_keymap("o", "sl"    , "<cmd>HopLine<cr>", opts)

set_keymap("n", "s/"    , "<cmd>HopPattern<cr>", opts)
set_keymap("o", "s/"    , "<cmd>HopPattern<cr>", opts)
