Post = require '../models/Post'

# Get single post
exports.getPost = (req, res) ->
  Post.findById(req.params.id).populate('tags').exec (err, post) ->
    res.status(500).json err if err
    res.send post

# Get multiple posts
exports.getMultiplePosts = (req, res) ->
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

  Post.find(req.query).sort(createdAt: sortOption).limit(limit).skip(skip).populate('tags').exec (err, posts) ->
    res.status(500).json err if err
    res.send posts: posts

# Add post
exports.addPost = (req, res) ->
  Post.create req.body, (err, savedPost) ->
    if err
      res.status(400).json err
      console.log err
    else res.status(201).json 'OK'

# Edit post
exports.editPost = (req, res) ->
  Post.findByIdAndUpdate req.params.id, req.body, (err, resource) ->
    if err
      res.status(500).json err
      console.log err
    else res.status(200).json 'OK' # if resource

# Delete post
exports.deletePost = (req, res) ->
  Post.findByIdAndRemove req.params.id, (err) ->
    res.status(500).json err if err
    res.status(200).json 'OK'
