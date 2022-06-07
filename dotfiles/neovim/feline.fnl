(module jlle.feline
  {require {a aniseed.core
            s aniseed.string
            nvim aniseed.nvim
            feline feline
            vimode feline.providers.vi_mode
            file_prov feline.providers.file
            pinfo package-info}})

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
(def vi-mode-colors {"NORMAL" magenta
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
  {:bg (a.get vi-mode-colors (vimode.get_vim_mode) magenta)
   :fg "#282c34"
   :style "bold"})

(defn file-prov [component opts]
  (let [(r nterm-name)
        (pcall #(nvim.buf_get_var (nvim.get_current_buf) :nterm_name))]
    (if r
      (values nterm-name)
      (file_prov.file_info component {:type "relative-short"}))))

(def active-left
  [{:hl {:fg blue} :provider "▊ "}

   ;; VIM mode
   {:hl vimode-hl :provider vimode.get_vim_mode :right_sep " "}

   ;; File name
   {:hl {:bg bg :fg blueText :style "bold"}
    :provider file-prov}

   ;; File size
   {:provider "file_size"
    :left_sep " "
    :right_sep [" "
                {:hl {:bg "#1F1F23" :fg "#D0D0D0" :style "NONE"}
                 :str "slant_left_2_thin"}
                " "]}

   ;; Git
   {:hl {:bg "black" :fg "white" :style "bold"}
    :provider "git_branch"
    :right_sep {:hl {:bg "black" :fg "NONE"} :str " "}}
   {:hl {:bg "black" :fg "green" :style "NONE"}
    :provider "git_diff_added"}
   {:hl {:bg "black" :fg "orange" :style "NONE"}
    :provider "git_diff_changed"}
   {:hl {:bg "black" :fg "red" :style "NONE"}
    :provider "git_diff_removed"
    :right_sep {:hl {:bg "black" :fg "NONE"} :str " "}}

   ;; LSP
   {:hl {:fg "red" :style "NONE"}
    :provider "diagnostic_errors"}
   {:hl {:fg "yellow" :style "NONE"}
    :provider "diagnostic_warnings"}
   {:hl {:fg "cyan" :style "NONE"}
    :provider "diagnostic_hints"}
   {:hl {:fg "skyblue" :style "NONE"}
    :provider "diagnostic_info"}])

(def active-right
  [{:provider pinfo.get_status
    :hl {:style "bold"}}
   {:provider "position"
    :right_sep [{:hl {:bg "#1F1F23" :fg "#D0D0D0" :style "NONE"}
                 :str "slant_right_2_thin"}]}

   {:hl {:style "bold"}
    :left_sep " " :right_sep " "
    :provider "line_percentage"}
   {:hl {:fg "skyblue" :style "bold"}
    :provider "scroll_bar"}])

(def inactive-left
  [
   {:hl {:bg purple :fg blueText}
    :left_sep {:hl {:bg purple :fg "NONE"} :str " "}
    :provider "file_type"
    :right_sep [{:hl {:bg purple :fg "NONE"} :str " "}
                "slant_right"]}
   {:left_sep " "
    :type :relative
    :provider file-prov}])

(def inactive-right [])

(def components {:active [active-left active-right]
                 :inactive [inactive-left inactive-right]})

(feline.setup {:components components})
; (feline.reset_highlights)
