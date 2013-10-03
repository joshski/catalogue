routism = require 'routism'

current search uri = nil

search (uri) =
    $('#detail').fade out 100
    u = uri.to string()
    if (current search uri != u)
        $('#results').html("")
        $('#results').load(u + ' #results > *')
        current search uri := u

detail (uri) =
    $('#detail').html("")
    $('#detail').fade in 100
    $('#detail').load(uri.to string() + ' #detail > *')

routes = routism.compile [
    { pattern = '/', route = search }
    { pattern = '/items/:id', route = detail }
]

load (url) =
    uri = @new URI(url)
    route = routes.recognise(uri.path()).route
    route(uri)

find href for (event) =
    t = event.target
    if (t && t.get attribute)
        t.get attribute "href"

bind history () =

    History.Adapter.bind (window, 'statechange')
        state = History.get state()
        load (state.url)

    document.body.add event listener "click" @(event)
        if (event.meta key || event.ctrl key)
            return

        href = find href for (event)
        if (href)
            event.prevent default ()
            History.push state ({ url = href }, href, href)
            return (false)

    for each @(form) in (document.forms)
        if (form.method.to lower case() == "get")
            form.add event listener "submit" @(event)
                event.prevent default ()
                action = form.action || window.location.href
                href = action + "?" + $(form).serialize()
                History.push state ({ url = href }, href, href)
                return (false)


supports history = not(not(window.history @and history.pushState))

if (supports history)
    bind history()