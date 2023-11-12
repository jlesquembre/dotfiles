(module jlle.myconfig
  {require {a aniseed.core
            s aniseed.string
            nvim aniseed.nvim
            h harpoon
            hmark harpoon.mark
            hcmd harpoon.cmd-ui
            hui harpoon.ui
            spectre spectre
            oil oil
            other other-nvim}})

; Move visual selection UP/DOWN
(vim.keymap.set "v" "J" ":m '>+1<CR>gv=gv")
(vim.keymap.set "v" "K" ":m '<-2<CR>gv=gv")

(set vim.o.guicursor (s.join "," ["n-v-c:block"
                                  "i-ci-ve:ver50"
                                  "r-cr:hor20"
                                  "o:hor50"
                                  "sm:block-blinkwait175-blinkoff150-blinkon175"
                                  "a:blinkwait700-blinkoff400-blinkon250"]))
                                  ; "n-v-c:blinkwait700-blinkoff400-blinkon250"]))

(other.setup
  {:mappings [{:pattern "(.*).ts$"
               :target [{:target "%1.css"}
                        {:target "%1.scss"}]}

              {:pattern "(.*).css$"
               :target "%1.ts"}

              {:pattern "(.*).scss$"
               :target "%1.ts"}]})

; Harpoon + projectionist
(h.setup {})
(let [kmap "<leader>a"
      opts {:noremap true}]
  (vim.keymap.set "n" (.. kmap "a") (fn [] (other.open)) opts)
  (vim.keymap.set "n" (.. kmap "v") (fn [] (other.openVSplit)) opts)
  (vim.keymap.set "n" (.. kmap "x") (fn [] (other.openSplit)) opts)
  (vim.keymap.set "n" (.. kmap "t") (fn [] (other.openTabNew)) opts)

  (vim.keymap.set "n" (.. kmap "s") hmark.add_file opts)
  (vim.keymap.set "n" (.. kmap "m") hui.toggle_quick_menu opts)
  (vim.keymap.set "n" (.. kmap "c") hcmd.toggle_quick_menu opts)

  (vim.keymap.set "n" (.. kmap "h") (fn [] (hui.nav_file 1)) opts)
  (vim.keymap.set "n" (.. kmap "j") (fn [] (hui.nav_file 2)) opts)
  (vim.keymap.set "n" (.. kmap "k") (fn [] (hui.nav_file 3)) opts)
  (vim.keymap.set "n" (.. kmap "l") (fn [] (hui.nav_file 4)) opts))


; Search and replace
(spectre.setup
  {:highlight {:ui "String"
               :search "GREEN"
               :replace "RED"}})
(let [kmap "<leader>r"
      opts {:noremap true}]
  (vim.keymap.set "n" (.. kmap "r") spectre.open opts)
  (vim.keymap.set "n" (.. kmap "w") (fn [] (spectre.open_visual {:select_word true}) opts)))

; fugitive: Disable editorconfig
(nvim.create_autocmd
  "FileType"
  {:pattern "fugitive"
   :callback (fn [] (set vim.b.editorconfig  false))})

; Add filetype for .env files
(nvim.create_autocmd
  "FileType"
  {:pattern "dotenv"
   :callback (fn [args]
               (vim.treesitter.start args.buf "bash")
               (set vim.o.commentstring "#%s"))})

(nvim.create_autocmd
  "FileType"
  {:pattern "sql"
   :callback (fn [args] (set vim.o.commentstring "--%s"))})

(vim.filetype.add
  {:extension
   {"env" "dotenv"
    "envrc" "sh"}

   :filename
   {".env" "dotenv"
    ".envrc" "sh"}

   :pattern
   {"%.env.*" "dotenv"
    "%.envrc.*" "sh"}})


(oil.setup
  {:view_options {:show_hidden  true}})

(vim.keymap.set "n" "-" (fn [] (oil.open)) {:desc "Open parent directory"})
