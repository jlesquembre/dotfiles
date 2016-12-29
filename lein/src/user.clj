(ns user
 (:require [clojure.tools.namespace.repl :as tnr]
           [prc]
           [proto-repl.saved-values]))

(defn start
  []
  (println "Start completed"))

(defn reset []
  (tnr/refresh :after 'user/start))

(println "~/.lein/src/user.clj loaded")
