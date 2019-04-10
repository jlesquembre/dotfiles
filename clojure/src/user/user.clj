(ns user
  (:require
    [clojure.java.classpath :as classpath]
    [clojure.java.io :as io]
    [clojure.reflect :refer [reflect]]
    [lambdaisland.deep-diff :as ddiff]
    [com.gfredericks.dot-slash-2 :as dot-slash-2]))


;; ------------
;;
;; Global utils
;;
;; ------------

(require '[sc.api :refer [letsc defsc]])

(defmacro letsc*
  "Like letsc, but uses the last (most recently evaluated) EP id."
  [& body]
  `(letsc ~(sc.api/last-ep-id) ~@body))

(defmacro defsc*
  "Like defsc, but uses the last (most recently evaluated) EP id."
  []
  `(defsc ~(sc.api/last-ep-id)))

; From
; https://github.com/jorinvo/clj-scratch
(defn jmethods
  "Print methods of a Java object"
  [o]
  (->> o
      reflect
      :members
      (filter :exception-types)
      (sort-by :name)
      (map #(select-keys % [:name :parameter-types]))))

;; See
;; https://github.com/gfredericks/dot-slash-2
(dot-slash-2/!
 '{. [{:var clojure.repl/doc
       :name d}

      {:var lambdaisland.deep-diff/diff
       :name diff}

      {:var user/letsc*
       :name letsc}
      {:var user/defsc*
       :name defsc}
      sc.api/spy

      user/jmethods

      clojure.tools.namespace.repl/refresh
      clojure.repl/apropos
      clojure.repl/dir
      clojure.java.shell/sh
      ; clojure.data/diff

      com.gfredericks.repl/pp]})

;; -----------
;;
;; clj -A:user
;;
;; -----------

;; Trick to load all user.clj files in path
;; Usage: clj -A:user:other-alias
;; See
;; https://clojureverse.org/t/how-are-user-clj-files-loaded/3842/2
;; https://github.com/gfredericks/user.clj

(defn- static-classpath-dirs
  []
  (mapv #(.getCanonicalPath  %) (classpath/classpath-directories)))

(defn user-clj-paths
  []
  (->> (static-classpath-dirs)
    (map #(io/file % "user.clj"))
    (filter #(.exists %))))


(defn load-user!
  [f]
  (try
    (println (str "Loading " f))
    (load-file (str f))
    (catch Exception e
      (binding [*out* *err*]
        (printf "WARNING: Exception while loading %s\n" f)
        (println e)))))


(defn load-all-user!
  []
  (let [paths (user-clj-paths)]
    (println (str "Loading " (first paths)))
    (doall
      (map load-user! (rest paths)))))

(load-all-user!)
