routism = require 'routism'

search (uri) =
    $('#results').load(uri.toString() + " #results")

detail (uri) =
    $('#detail').load(uri.toString() + " #detail")

routes = routism.compile [
    { pattern = '/', route = search }
    { pattern = '/items/:id', route = detail }
]

History.Adapter.bind (window, 'statechange')
    state = History.get state()
    load (state.url)

document.body.add event listener "click" @(event)
    href = find href for (event)
    if (href)
        event.prevent default ()
        History.push state ({ url = href }, "State", href)
        return (false)

for each @(form) in (document.forms)
    if (form.method.to lower case() == "get")
        form.add event listener "submit" @(event)
            event.prevent default ()
            action = form.action || window.location.href
            load (action + "?" + $(form).serialize())
            return (false)

load (url) =
    uri = @new URI(url)
    route = routes.recognise(uri.path()).route
    route(uri)

find href for (event) =
    t = event.target
    if (t && t.get attribute)
        return (t.get attribute "href")
