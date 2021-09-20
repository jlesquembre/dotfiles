(module jlle.feline
  {require {a aniseed.core
            s aniseed.string
            nvim aniseed.nvim
            feline feline
            vimode feline.providers.vi_mode
            file_prov feline.providers.file
            p feline.presets}})

(def purple "#5d4d7a")
(def magenta "#c678dd")
(def blue "#51afef")
(def cyan  "#008080")
(def darkblue  "#081633")
(def yellow "#fabd2f")
(def green "#afd700")
(def orange "#FF8800")
(def red "#ec5f67")

(def bg "#1F1F23")
(def blueText "#8FBCBB")

; https://github.com/famiu/feline.nvim/blob/53bad42dee7bd3db08039f644df03b49ae887b3e/lua/feline/providers/vi_mode.lua#L5
(def colors {"NORMAL" magenta
             "INSERT" green
             "VISUAL" blue
             "OP" yellow
             "LINES" blue
             "BLOCK" blue
             "SELECT" orange
             "V-REPLACE" purple
             "REPLACE" purple
             "COMMAND" red
             "ENTER" red
             "MORE" red
             "CONFIRM" red
             "SHELL" green
             "TERM" green
             "NONE" magenta})

(def file-info-hl
  {:bg bg :fg blueText :style "bold"})

(defn vimode-hl []
  {:bg (a.get colors (vimode.get_vim_mode) magenta)
   :fg "#282c34"
   :style "bold"})

(defn file-prov [component winid]
  (let [(r nterm-name)
        (pcall #(nvim.buf_get_var (nvim.win_get_buf winid) :nterm_name))]
    (if r
      nterm-name
      (file_prov.file_info component winid))))

(defn update-presets []
  (let [components (a.get-in p [:default :components])]

    (a.assoc-in components [:active 1 1 :hl :fg] blue)

    ;; VIM mode
    (a.assoc-in components [:active 1 2] {:provider vimode.get_vim_mode
                                          :right_sep ""
                                          :hl vimode-hl})
    ;; FILE NAME
    (a.assoc-in components [:active 1 3 :hl] file-info-hl)
    (a.assoc-in components [:active 1 3 :left_sep] " ")
    (a.assoc-in components [:active 1 3 :right_sep] "")
    (a.assoc-in components [:active 1 3 :type] :relative)
    (a.assoc-in components [:active 1 3 :provider] file-prov)

    ;; Swap POSITION and GIT
    (let [left  (a.get-in components [:active 1])
          right (a.get-in components [:active 2])
          position-provider (table.remove left 5)]
      (table.insert left 5 (table.remove right 4))
      (table.insert left 5 (table.remove right 3))
      (table.insert left 5 (table.remove right 2))
      (table.insert left 5 (table.remove right 1))
      (a.assoc-in left [5 :left_sep] " ")

      (table.insert right 1 position-provider)
      (a.assoc-in right [2 :left_sep] " ")
      (a.assoc-in right [1 :right_sep 1] ""))

    ;;; INACTIVE

    ;; FILE TYPE
    (let [style {:bg purple :fg blueText :style "NONE"}]
      (a.assoc-in components [:inactive 1 1]
                  {:hl style
                   :provider "file_type"
                   :left_sep {:hl style :str " "}
                   :right_sep [{:hl style :str " "} "slant_right"]}))
    ;; FILE NAME
    (a.assoc-in components [:inactive 1 2]
                           {:left_sep " "
                            :type :relative
                            :provider file-prov})

    (feline.setup {:components components})
    ; (feline.reset_highlights)
    components))

(update-presets)
