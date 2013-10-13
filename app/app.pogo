express = require 'express'
browserify = require 'browserify-middleware'
pogoify = require 'pogoify'
stylus = require 'stylus'

views directory = "#(__dirname)/views"
public directory = "#(__dirname)/public"

browserify.settings {
    transform = ['pogoify']
    no parse = require './client/browserify'.no parse()
}

exports.create app (options) =
    repo = options.repository

    app = express()
    app.set 'view engine' 'jade'
    app.set 'views' (views directory)

    app.use(stylus.middleware {
        src = views directory
        dest = public directory
        compile (str, path) =
            stylus(str).set('filename', path).set('compress', true)
    })

    app.use(express.static(public directory))

    settings = {
        basedir = "#(__dirname)/client/"
        extensions = ['.js', '.pogo']
    }

    app.get '/client.js' (browserify "#(__dirname)/client/client.pogo" (settings))

    app.get '/' @(req, res)
        repo.search (req.query) @(err, results)
            res.render 'search' {
                criteria = req.query
                results = results
                show home page = req.query.keywords == ''
            }

    app.get '/search.json' @(req, res)
        repo.search (req.query) @(err, results)
            res.json (results)

    app.get '/items/:id' @(req, res)
        repo.find (req.params.id) @(err, item)
            res.render 'detail' { item = item }

    app