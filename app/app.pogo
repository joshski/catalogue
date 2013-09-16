express = require 'express'
browserify = require 'browserify-middleware'
pogoify = require 'pogoify'
bundle = require './client/bundle'

browserify.settings { transform = ['pogoify'] }

exports.create app (options) =
    repo = options.repository

    app = express()
    app.set 'view engine' 'jade'
    app.set 'views' "#(__dirname)/views"

    app.get '/bundle.js' @(req, res)
        res.set({ 'Content-Type' = 'text/javascript' })
        res.send (bundle.render())

    app.get '/client.js' (browserify "#(__dirname)/client/client.pogo")

    app.get '/' @(req, res)
        repo.search (req.query) @(err, results)
            res.render 'search' { criteria = req.query, results = results }

    app.get '/search.json' @(req, res)
        repo.search (req.query) @(err, results)
            res.json (results)

    app.get '/items/:id' @(req, res)
        repo.find (req.params.id) @(err, item)
            res.render 'detail' { item = item }

    app