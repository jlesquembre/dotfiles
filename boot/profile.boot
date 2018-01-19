(require 'boot.repl)

;(swap! boot.repl/*default-dependencies*
;       concat '[[cider/cider-nrepl "0.15.0"]])
                ;[refactor-nrepl "2.3.1"]
                ;[cljfmt "0.5.6"]
                ;[slamhound "1.5.5"]])

;(swap! boot.repl/*default-middleware*
;       concat '[cider.nrepl/cider-middleware])
;                refactor-nrepl.middleware/wrap-refactor])

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
  "CIDER repl
  boot cider"
  []
  (require 'boot.repl)
  (set-env!
    :dependencies
    #(into % '[[org.clojure/tools.nrepl "0.2.13"]
               [org.clojure/tools.namespace "0.3.0-alpha4"]
               [cider/cider-nrepl "0.16.0"]
               [refactor-nrepl "2.3.1"]
               ;[cljfmt "0.5.6"]
               ; [expound "0.3.1"]
               [slamhound "1.5.5"]]))
  (swap! @(resolve 'boot.repl/*default-middleware*)
         concat '[cider.nrepl/cider-middleware
                  refactor-nrepl.middleware/wrap-refactor])
  identity)


(deftask cider-extra
  "CIDER repl with core.async cljs-ajax
  boot cider-extra"
  []
  (set-env!
    :dependencies
    #(into % '[[org.clojure/core.async "0.3.443"]
               [cljs-ajax "0.7.3"]
               [criterium "0.4.4"]
               [com.taoensso/tufte "1.1.2"]
               [com.rpl/specter "1.1.0"]
               [com.cognitect/transit-clj "0.8.300"]]))
               ; [rewrite-clj "0.6.0"]
               ; [zprint "0.4.3"]]))
  (cider))


(deftask check-sources []
  (set-env!
    :dependencies
    #(into % '[[tolitius/boot-check "RELEASE"]]))
    ; :source-paths #{"src" "test"})

  (require '[tolitius.boot-check :as check])
  (let [with-yagni (resolve 'check/with-yagni)
        with-kibit (resolve 'check/with-kibit)]
    (comp
      (with-yagni)
      (with-kibit))))
      ; (check/with-eastwood)
      ; (check/with-bikeshed)))
