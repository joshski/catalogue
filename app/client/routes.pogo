routism = require 'routism'
$ = require 'jquery'

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

module.exports = routes