app = module.exports = do require 'express'

postController = require './controllers/projectController.coffee'

# Test
app.get '/test', postController.test

# Create
app.post '/projects', postController.addProject

# Read
app.get '/projects', postController.getProjects

# Update
app.put '/projects/:id', postController.editProject

# Delete
app.delete '/projects/:id', postController.deleteProject
