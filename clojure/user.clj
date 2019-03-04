(ns user
  (:require
    [clojure.java.classpath :as classpath]
    [clojure.java.io :as io]
    [com.gfredericks.dot-slash-2 :as dot-slash-2]))


(require '[sc.api :refer [letsc defsc]])

(defmacro letsc*
  "Like letsc, but uses the last (most recently evaluated) EP id."
  [& body]
  `(letsc ~(sc.api/last-ep-id) ~@body))

(defmacro defsc*
  "Like defsc, but uses the last (most recently evaluated) EP id."
  []
  `(defsc ~(sc.api/last-ep-id)))

;; See
;; https://github.com/gfredericks/dot-slash-2
(dot-slash-2/!
 '{. [{:var clojure.repl/doc
       :name d}

      {:var user/letsc*
       :name letsc}
      {:var user/defsc*
       :name defsc}
      sc.api/spy

      clojure.repl/apropos
      clojure.repl/dir
      clojure.java.shell/sh
      clojure.data/diff

      com.gfredericks.repl/pp]})


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
    (prn (str "Loading " f))
    (load-file (str f))
    (catch Exception e
      (binding [*out* *err*]
        (printf "WARNING: Exception while loading %s\n" f)
        (prn e)))))


(defn load-all-user!
  []
  (let [paths (user-clj-paths)]
    (prn (str "Load " (first paths)))
    (doall
      (map load-user! (rest paths)))))

(load-all-user!)
