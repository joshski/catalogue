colours = ['red', 'green', 'blue', 'yellow', 'black', 'gold', 'silver']
things = ['duck', 'sausage', 'plate', 'hairbrush', 'skateboard']
items = {}
next id () =
    if (next id.id == undefined)
        next id.id = 0

    next id.id = next id.id + 1
    next id.id.to string()

for each @(colour) in (colours)
    for each @(thing) in (things)
        item id = next id()
        items.(item id) = {
            id = item id
            name = "#(colour) #(thing)"
            price = "#(item id).99"
        }

(item) matches (criteria) =
    if (criteria.keywords)
        if (item.name.index of (criteria.keywords) == -1)
            return (false)

    true

find (id, callback) =
    item = items.(id)
    if (item)
        callback (nil, item)
    else
        callback (@new Error ("No such item"), nil)

search (criteria, callback) =
    results = { hits = [], total = 0 }
    for @(id) in (items)
        if ((items.(id)) matches (criteria))
            results.hits.push(items.(id))
            results.total = results.total + 1

    callback(nil, results)

exports.find = find
exports.search = search
