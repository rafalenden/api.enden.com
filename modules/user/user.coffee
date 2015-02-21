app = module.exports = do require 'express'

userController = require './controllers/userController.coffee'

# Check if user is authenticated
app.get '/user/is-authenticated', userController.isAuthenticated
