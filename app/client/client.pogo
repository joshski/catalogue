// need explicit .pogo extension
// https://github.com/substack/node-browserify/issues/326
require './browserify.pogo'
routes = require './routes.pogo'
$ = require 'jquery'
URI = require 'URIjs'

load (url) =
    uri = @new URI(url)
    route = routes.recognise(uri.path()).route
    route(uri)

find href for (event) =
    t = event.target
    if (t && t.get attribute)
        t.get attribute "href"

enhance anchors () =
    document.body.add event listener "click" @(event)
        if (event.meta key || event.ctrl key)
            return

        href = find href for (event)
        if (href)
            event.prevent default ()
            title = $(event.target).attr('title')
            History.push state ({ url = href, title = title }, title, href)
            return (false)

enhance forms () =
    for each @(form) in (document.forms)
        if (form.method.to lower case() == "get")
            form.add event listener "submit" @(event)
                event.prevent default ()
                action = form.action || window.location.href
                href = action + "?" + $(form).serialize()
                History.push state ({ url = href }, href, href)
                return (false)

bind history () =
    History.Adapter.bind (window, 'statechange')
        state = History.get state()
        load (state.url)

    enhance anchors ()
    enhance forms ()

supports history = not(not(window.history @and history.pushState))

if (supports history)
    bind history()
    $("body").add class("client-ready")
