; https://github.com/technomancy/leiningen/blob/master/doc/PROFILES.md

; Inpiration:
; https://github.com/junegunn/dotfiles/blob/master/profiles.clj

{:user
 {
  :plugins [[cider/cider-nrepl "0.14.0"]
            [lein-pprint "1.1.2"]]

  :dependencies [[proto-repl "0.3.1"]
                 [proto-repl-charts "0.3.2"]
                 [org.clojure/tools.namespace "0.2.11"]]

  :source-paths [#=(str #=(java.lang.System/getProperty "user.home")
                       "/.lein/src")]}}
