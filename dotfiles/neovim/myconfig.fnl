(module jlle.myconfig
  {require {a aniseed.core
            s aniseed.string
            nvim aniseed.nvim
            h harpoon
            hmark harpoon.mark
            hcmd harpoon.cmd-ui
            hui harpoon.ui}})

(vim.keymap.set "v" "J" ":m '>+1<CR>gv=gv")
(vim.keymap.set "v" "K" ":m '<-2<CR>gv=gv")

; Harpoon
(h.setup {})
(let [kmap "<leader>a"
      opts {:noremap true}]
  (vim.keymap.set "n" (.. kmap "a") hmark.add_file opts)
  (vim.keymap.set "n" (.. kmap "t") hui.toggle_quick_menu opts)
  (vim.keymap.set "n" (.. kmap "c") hcmd.toggle_quick_menu opts)

  (vim.keymap.set "n" (.. kmap "h") (fn [] hui.nav_file 1) opts)
  (vim.keymap.set "n" (.. kmap "j") (fn [] hui.nav_file 2) opts)
  (vim.keymap.set "n" (.. kmap "k") (fn [] hui.nav_file 3) opts)
  (vim.keymap.set "n" (.. kmap "l") (fn [] hui.nav_file 4) opts))
