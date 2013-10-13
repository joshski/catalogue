express = require 'express'
browserify = require 'browserify-middleware'
pogoify = require 'pogoify'
stylus = require 'stylus'
routes = require './routes'

views dir = "#(__dirname)/views"
public dir = "#(__dirname)/public"
client dir = "#(__dirname)/client"

browserify.settings {
    transform = ['pogoify']
    no parse = require './client/browserify'.no parse()
}

exports.create app (options) =
    app = express()
    app.set 'view engine' 'jade'
    app.set 'views' (views dir)

    app.use(stylus.middleware {
        src = views dir
        dest = public dir
        compile (str, path) =
            stylus(str).set('filename', path).set('compress', true)
    })

    app.use(express.static(public dir))

    settings = {
        basedir = client dir
        extensions = ['.js', '.pogo']
    }

    app.get '/client.js' (browserify "#(client dir)/client.pogo" (settings))

    routes.render (app, options)

    app