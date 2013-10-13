exports.render (app, options) =
    repo = options.repository

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