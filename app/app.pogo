express = require 'express'

exports.create app (options) =
    repo = options.repository

    app = express()
    app.set 'view engine' 'jade'

    app.get '/' @(req, res)
        repo.search (req.query) @(err, results)
            res.render 'search' { criteria = req.query, results = results }

    app.get '/search' @(req, res)
        repo.search (req.params) @(err, results)
            res.json (results)

    app.get '/items/:id' @(req, res)
        repo.find (req.params.id) @(err, item)
            res.render 'detail' { item = item }

    app