exports.render (app, options) =
    repo = options.repository

    app.get '/' @(req, res)
        repo.search (req.query) @(err, results)
            res.render 'search' {
                criteria = req.query
                results = results
            }

    app.get '/items/:id' @(req, res)
        repo.find (req.params.id) @(err, item)
            res.render 'detail' { item = item }
