(module jlle.sql_utils
  {require {a aniseed.core
            s aniseed.string
            nvim aniseed.nvim}})

(defonce db-conns {})
(var last-result nil)

(defn current_db []
  (if-let [conn (or vim.b.db vim.g.db)]
    (.. "[" (a.get db-conns conn) "]")
    "[NO DB]"))

(fn getlines
  [start_lnum end_lnum]
  (if end_lnum
    (vim.api.nvim_buf_get_lines 0 (a.dec start_lnum) end_lnum  false)
    (or (a.first (vim.api.nvim_buf_get_lines 0 (a.dec start_lnum) start_lnum false))
        "")))

(fn get-last-non-blank
  [start direction]
  (var pos start)
  (let [[end step] (if (= direction 1)
                     [(vim.api.nvim_buf_line_count 0) 1]
                     [1 -1])]
    (for [i start end step
          :until (s.blank? (getlines i))]
      (set pos i)))
  pos)


; (fn get-query
;   [line]
;   (let [line (or line (a.first (nvim.win_get_cursor 0)))
;         text (vim.trim (getlines line))]
;     (if (vim.startswith text "\\")
;       text
;       (getlines
;         (get-last-non-blank line -1)
;         (get-last-non-blank line 1)))))

(fn get-query-range
  [line]
  (let [line (or line (a.first (nvim.win_get_cursor 0)))
        text (vim.trim (getlines line))]
    (if (vim.startswith text "\\")
      [line line]
      (let [start (get-last-non-blank line -1)
            end (get-last-non-blank line 1)]
        [start end]))))


(var sql-ns (nvim.create_namespace "sql-ns"))
(var sql-timer nil)
(var timeout 300)

(fn highlight-range
  [start end hl-group]
  (let [bufnr (nvim.get_current_buf)]
    (nvim.buf_clear_namespace bufnr sql-ns 0 -1)
    (vim.highlight.range bufnr sql-ns
                         (or hl-group "OnSelect")
                         [(a.dec start) 0]
                         [(a.dec end) (a.count (getlines end))]
                         {:regtype "V" :inclusive true})
    (set sql-timer (vim.defer_fn
                     (fn []
                       (set sql-timer nil)
                       (when (nvim.buf_is_valid bufnr)
                         (nvim.buf_clear_namespace bufnr sql-ns 0 -1)))
                     timeout))))

(fn get-envs
  []
  (a.concat
    (a.filter
      (fn [[k v]] (or (vim.startswith k "DB_")
                      (vim.startswith k "DATABASE_")
                      (vim.endswith k "_DB")
                      (vim.endswith k "_DATABASE")))
      (a.kv-pairs (nvim.fn.environ)))
    (a.kv-pairs (vim.fn.DotenvRead))))


(fn set-db-connection
  []
  (vim.ui.select
    (get-envs)
    {:prompt "Title"
     :format_item (fn [[k v]] (.. k " -> " v))}
    (fn [[k v]]
      (if (not vim.g.db)
        (set vim.g.db v)
        (set vim.b.db v))
      (a.assoc db-conns v k)
      (vim.notify (.. "Connected to " k " -> " v)))))

(fn get-db-conn
  []
  (or vim.b.db vim.g.db))

(fn run-query
  []
  (if (not (get-db-conn))
    (vim.notify "No DB connection!" "error")
    (let [[start end] (get-query-range)]
      (highlight-range start end)
      (if (= start end)
        (vim.cmd (.. start "DB"))
        (vim.cmd (.. start "," end "DB"))))))

(fn show-current-db []
  (vim.notify
    (.. "DB URL: " (or (get-db-conn) "NO CONNECTED")
        "\nLast result: " (or last-result "EMPTY"))
    "info"))

(var sql_group (nvim.create_augroup "sql-group" {:clear true}))

(nvim.create_autocmd
  "FileType"
  {:pattern  "sql"
   :callback (fn []
               (vim.keymap.set "n" "<leader>zz" set-db-connection {:noremap true :buffer true})
               (vim.keymap.set "n" "cll" show-current-db {:noremap true :buffer true})
               (vim.keymap.set "n" "cpp" run-query {:noremap true :buffer true}))
   :group sql_group})


(nvim.create_autocmd
  "BufReadPost"
  {:pattern  "*.dbout"
   :callback (fn [opts]
               (set last-result (a.get opts :file))
               (set vim.g.last_dadbod_file last-result))
   :group sql_group})

(nvim.create_autocmd
  "TermOpen"
  {:pattern  "*.dbout"
   :callback (fn [opts]
               (vim.cmd "startinsert")
               (vim.keymap.set "t" "q"
                               (fn [] (nvim.buf_delete 0 {:force true}))
                               {:noremap true :buffer true}))
   :group sql_group})


(vim.keymap.set "n" "<leader>zm"
                (fn []
                  (if last-result
                    ; TODO open in float
                    (vim.cmd (.. ":-tabnew | call termopen('pspg -s 6 -f " last-result "')"))
                    (vim.notify "pspg error: No query" "error")))
                {:noremap true})
