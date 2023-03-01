local iron = require('iron')

iron.core.add_repl_definitions {
  ruby = {
    mycustom = {
      command = {"pry"}
    }
  },
  clojure = {
    lein_connect = {
      command = {"lein", "repl", ":connect"}
    }
  }
}

iron.core.set_config {
  preferred = {
    python = "ipython",
    clojure = "lein"
  }
}
