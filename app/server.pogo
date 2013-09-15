repo = require './repository'
app = require './app'.create app (repository: repo)

port = process.env.PORT || "3000"
app.listen (Number (port))
console.log "listening at #(port)"