require("gitsigns").setup({
  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    -- add          = {hl = 'GitSignsAdd'   , text = '▌', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    -- change       = {hl = 'GitSignsChange', text = '▌', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    -- add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    -- change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    -- delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- changedelete = { hl = "GitSignsChangeDelete", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },

  numhl = false,
  preview_config = {
    border = "single",
  },

  on_attach = function(bufnr)
    -- vim.fn.sign_define("GitSignsAdd", { culhl = "GitSignsAddCul" })
    -- vim.fn.sign_define("GitSignsChange", { culhl = "GitSignsChangeCul" })
    -- vim.fn.sign_define("GitSignsDelete", { culhl = "GitSignsDeleteCul" })
    -- vim.fn.sign_define("GitSignsChangeDelete", { culhl = "GitSignsChangeDeleteCul" })

    local gitsigns = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]h", bang = true })
      else
        gitsigns.nav_hunk("next")
      end
    end, { desc = "Next hunk" })

    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[h", bang = true })
      else
        gitsigns.nav_hunk("prev")
      end
    end, { desc = "Previous hunk" })

    -- Actions
    map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Toggle hunk" })
    map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk" })

    map("v", "<leader>hs", function()
      gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Stage selected hunk" })

    map("v", "<leader>hr", function()
      gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end, { desc = "Reset selected hunk" })

    map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

    map("n", "<leader>hb", function()
      gitsigns.blame_line({ full = true })
    end, { desc = "Blame line" })

    map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff this" })

    map("n", "<leader>hD", function()
      gitsigns.diffthis("~")
    end, { desc = "Diff this (~)" })

    map("n", "<leader>hQ", function()
      gitsigns.setqflist("all")
    end, { desc = "Quickfix hunks (all)" })
    map("n", "<leader>hq", gitsigns.setqflist, { desc = "Quickfix hunks" })

    -- Sometimes external commits don't trigger filewatch updates reliably.
    -- Force a refresh when coming back to the window/buffer or after Fugitive updates.
    local aug = vim.api.nvim_create_augroup("GitsignsRefresh" .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
      group = aug,
      buffer = bufnr,
      callback = gitsigns.refresh,
    })
    vim.api.nvim_create_autocmd("User", {
      group = aug,
      pattern = "FugitiveChanged",
      callback = gitsigns.refresh,
    })
  end,
})
