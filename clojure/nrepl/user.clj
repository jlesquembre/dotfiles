(ns user
  (:require
    [nrepl.cmdline :as nrepl-cli]
    [nrepl.core :as nrepl]
    [nrepl.transport :as transport]))

(defn nrepl-handler []
  (require 'cider.nrepl)
  (ns-resolve 'cider.nrepl 'cider-nrepl-handler))

(def nrepl-options {:bind "localhost"
                    :middleware ["refactor-nrepl.middleware/wrap-refactor"
                                 "cider.nrepl/cider-middleware"
                                 "cider.piggieback/wrap-cljs-repl"]
                    :transport #'transport/bencode
                    :handler (nrepl-handler)})

(defn- clean-up-and-exit
  "Performs any necessary clean up and calls `(System/exit status)`."
  [status]
  (println "Shutting down...")
  (shutdown-agents)
  (flush)
  (binding [*out* *err*] (flush))
  (System/exit status))

(defn- handle-interrupt
  [signal]
  (let [transport (:transport @nrepl-cli/running-repl)
        client (:client @nrepl-cli/running-repl)]
    (if (and transport client)
      (doseq [res (nrepl/message client {:op :interrupt})]
        (when (= ["done" "session-idle"] (:status res))
          (clean-up-and-exit 0)))
      (clean-up-and-exit 0))))

(try
  (nrepl-cli/set-signal-handler! "INT" handle-interrupt)
  (when (defonce server (nrepl-cli/start-server nrepl-options))
    (nrepl-cli/ack-server server nrepl-options)
    (println (nrepl-cli/server-started-message server nrepl-options))
    (nrepl-cli/save-port-file server nrepl-options))
 (catch clojure.lang.ExceptionInfo ex
   (let [{:keys [::kind ::status]} (ex-data ex)]
     (when (= kind ::exit)
       (clean-up-and-exit status))
     (throw ex))))


; (nrepl-cli/-main  "-i") ; "--middleware" "[refactor-nrepl.middleware/wrap-refactor cider.nrepl/cider-middleware cider.piggieback/wrap-cljs-repl]")

; (when (defonce server (nrepl-cli/start-server nrepl-options))
;   (nrepl-cli/ack-server server nrepl-options)
;   (println (nrepl-cli/server-started-message server nrepl-options))
;   (nrepl-cli/save-port-file server nrepl-options))
