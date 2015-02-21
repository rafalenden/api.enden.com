app = module.exports = do require 'express'

postController = require './controllers/postController.coffee'

# Create
app.post '/blog', postController.addPost

# Read
app.get '/blog', postController.getMultiplePosts
app.get '/blog/:id', postController.getPost

# Update
app.put '/blog/:id', postController.editPost

# Delete
app.delete '/blog/:id', postController.deletePost
