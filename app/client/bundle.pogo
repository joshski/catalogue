files = [
    'jquery.js'
    'uri.js'
]

fs = require 'fs'
js = false

exports.render () = js || render()

render () =
    js := ""
    for each @(file) in (files)
        contents = fs.read file sync "#(__dirname)/bundle/#(file)"
        js := "#(js)//----------- #(file) -----------\n\n#(contents)\n\n"

    js
