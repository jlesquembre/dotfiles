(local core (require :nfnl.core))
(local s (require :nfnl.string))
(local spectre (require :spectre))
(local oil (require :oil))
(local other (require :other-nvim))

;; Custom mappings

(vim.keymap.set "n" "<leader>q" "<cmd>q<cr>")
(vim.keymap.set "n" "<leader>s" "<cmd>update<cr>" {:silent true})
(vim.keymap.set "i" "<C-s>" "<C-o>:w<cr>")

;; move vertically by visual line
(vim.keymap.set "n" "j" "gj")
(vim.keymap.set "n" "k" "gk")

; Move visual selection UP/DOWN
(vim.keymap.set "v" "J" ":m '>+1<CR>gv=gv")
(vim.keymap.set "v" "K" ":m '<-2<CR>gv=gv")

;; Customize cursor
(set vim.o.guicursor (s.join "," ["n-v-c:block"
                                  "i-ci-ve:ver50"
                                  "r-cr:hor20"
                                  "o:hor50"
                                  "sm:block-blinkwait175-blinkoff150-blinkon175"
                                  "a:blinkwait700-blinkoff400-blinkon250"]))
                                  ; "n-v-c:blinkwait700-blinkoff400-blinkon250"]))
;; other.nvim setup
(other.setup
  {:mappings [{:pattern "(.*).ts$"
               :target "%1.css"}

              {:pattern "(.*).css$"
               :target "%1.ts"}

              {:pattern "(.*).scss$"
               :target "%1.ts"}]
   :hooks {:filePickerBeforeShow (fn [files]
                                   (let [existing-files (core.filter
                                                          (fn [x] (core.get x :exists))
                                                          files)]
                                     (if (core.empty? existing-files)
                                       files
                                       existing-files)))}})


; Harpoon + projectionist
; (h.setup {})
(let [kmap "<leader>a"
      opts {:noremap true}]
  (vim.keymap.set "n" (.. kmap "a") (fn [] (other.open)) opts)
  (vim.keymap.set "n" (.. kmap "v") (fn []
                                      (let [v vim.o.splitright]
                                        (set vim.o.splitright true)
                                        (other.openVSplit)
                                        (set vim.o.splitright v)))
                  opts)
  (vim.keymap.set "n" (.. kmap "x") (fn [] (other.openSplit)) opts)
  (vim.keymap.set "n" (.. kmap "t") (fn [] (other.openTabNew)) opts))

  ; (vim.keymap.set "n" (.. kmap "s") hmark.add_file opts)
  ; (vim.keymap.set "n" (.. kmap "m") hui.toggle_quick_menu opts)
  ; (vim.keymap.set "n" (.. kmap "c") hcmd.toggle_quick_menu opts)

  ; (vim.keymap.set "n" (.. kmap "h") (fn [] (hui.nav_file 1)) opts)
  ; (vim.keymap.set "n" (.. kmap "j") (fn [] (hui.nav_file 2)) opts)
  ; (vim.keymap.set "n" (.. kmap "k") (fn [] (hui.nav_file 3)) opts)
  ; (vim.keymap.set "n" (.. kmap "l") (fn [] (hui.nav_file 4)) opts))


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
(vim.api.nvim_create_autocmd
  "FileType"
  {:pattern "fugitive"
   :callback (fn [] (set vim.b.editorconfig  false))})

; Add filetype for .env files
(vim.api.nvim_create_autocmd
  "FileType"
  {:pattern "dotenv"
   :callback (fn [args]
               (vim.treesitter.start args.buf "bash")
               (set vim.bo.commentstring "# %s"))})

(vim.api.nvim_create_autocmd
  "FileType"
  {:pattern "sql"
   :callback (fn [args] (set vim.bo.commentstring "-- %s"))})

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
  {:view_options {:show_hidden  true}
   :watch_for_changes true
   :keymaps {"<C-l>"  "actions.refresh"
             "<C-s>" {:desc "Open right"
                      :callback (fn [] (oil.select {:vertical true :split "belowright"}))}}})

(vim.keymap.set "n" "-" (fn [] (oil.open)) {:desc "Open parent directory"})
