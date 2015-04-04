Page = require '../models/Page'

# Get single page
exports.getPage = (req, res) ->
  Page.findById(req.params.id).exec (err, page) ->
    res.status(500).json err if err
    res.send page

# Get multiple pages
exports.getMultiplePages = (req, res) ->
  skip = 0
  limit = 0
  sortOption = -1
  status = true

  if req.query.skip?
    skip = req.query.skip
    delete req.query.skip

  if req.query.limit?
    limit = req.query.limit
    delete req.query.limit

  if req.query.sort?
    sortOption = req.query.sort
    delete req.query.sort

  # req.query.status ?= true

  Page.find(req.query).sort(createdAt: sortOption).limit(limit).skip(skip).exec (err, pages) ->
    res.status(500).json err if err
    res.send pages: pages

# Add page
exports.addPage = (req, res) ->
  Page.create req.body, (err, savedPage) ->
    if err
      res.status(400).json err
      console.log err
    else res.status(201).json 'OK'

# Edit page
exports.editPage = (req, res) ->
  console.log req.headers
  Page.findByIdAndUpdate req.params.id, req.body, (err, resource) ->
    if err
      res.status(500).json err
      console.log err
    else res.status(200).json 'OK' # if resource

# Delete page
exports.deletePage = (req, res) ->
  Page.findByIdAndRemove req.params.id, (err) ->
    res.status(500).json err if err
    res.status(200).json 'OK'
