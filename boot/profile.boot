(deftask proto
  "Proto REPL profile
   boot proto repl"
  []
  ;(def dev-profile-path (str #=(java.lang.System/getProperty "user.home")
  ;                           "/.boot/src"]
  (set-env!
   ;:init-ns 'user
   ;:source-paths #(into % [dev-profile-path])
   :dependencies #(into % '[[proto-repl "0.3.1"]
                            [proto-repl-charts "0.3.2"]
                            [org.clojure/tools.namespace "0.2.11"]]))

  ;; Makes clojure.tools.namespace.repl work per https://github.com/boot-clj/boot/wiki/Repl-reloading
  (require 'clojure.tools.namespace.repl)
  (eval '(apply clojure.tools.namespace.repl/set-refresh-dirs
                (get-env :directories)))

  identity)


(deftask cider
  "CIDER profile
  boot cider repl"
  []
  (require 'boot.repl)
  (swap! @(resolve 'boot.repl/*default-dependencies*)
         concat '[[org.clojure/tools.nrepl "0.2.12"]
                  [cider/cider-nrepl "0.14.0"]
                  [refactor-nrepl "2.2.0"]])
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)
