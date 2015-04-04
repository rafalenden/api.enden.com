app = module.exports = do require 'express'

pageController = require './controllers/pageController.coffee'

# Create
app.post '/page', pageController.addPage

# Read
app.get '/page', pageController.getMultiplePages
app.get '/page/:id', pageController.getPage

# Update
app.put '/page/:id', pageController.editPage

# Delete
app.delete '/page/:id', pageController.deletePage
