# Include node modules
express = require 'express'
{join} = require 'path'
bodyParser = require 'body-parser'
errorHandler = require 'errorhandler'
http = require 'http'
https = require 'https'
fs = require 'fs'
morgan = require 'morgan'

# Initialise app
app = module.exports = express()

# Get configuration
config = require 'config'

# Connect to MongoDB
mongoose = require 'mongoose'
mongoose.connect config.get 'mongoUrl'
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')

# CORS middleware
allowCrossDomain = (req, res, next) ->
  res.header 'Access-Control-Allow-Origin', '*'
  res.header 'Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  res.header 'Access-Control-Allow-Methods', 'GET, PUT, POST, DELETE'
  next()

app.use allowCrossDomain
app.use bodyParser.json()
app.use bodyParser.urlencoded extended: true
app.use morgan 'dev'

# Configuration
app.set 'views', join(__dirname, 'views')
app.set 'view engine', 'jade'

# Load modules
app.use require './modules/system'
app.use require './modules/blog'
app.use require './modules/project'
app.use require './modules/help'
app.use require './modules/user'
app.use require './modules/page'

# Catch 404 and forwarding to error handler
app.use (req, res, next) ->
  err = new Error 'Not Found'
  err.status = 404
  next err

# Development error handler
# Print stacktrace
if app.settings.env is 'development'
  app.use (err, req, res, next) ->
    res.status err.status ? 500
    res.send message: err.message, error: err
  app.use errorHandler dumpExceptions: true, showStack: true

# Production error handler
# No stacktraces leaked to user
else if app.settings.env isnt 'development'
  app.use (err, req, res, next) ->
    res.status err.status ? 500
    res.send message: err.message, error: {}
  app.use errorHandler()

# Register exit handlers
exitApp = ->
  console.log 'Shutting down...'
  process.exit 0

process.on 'SIGINT', exitApp
process.on 'SIGTERM', exitApp
process.on 'uncaughtException', (err) ->
  console.log err

privateKey  = fs.readFileSync config.get('https').privateKey, 'utf8'
certificate = fs.readFileSync config.get('https').certificate, 'utf8'
credentials = key: privateKey, cert: certificate

httpServer = http.createServer app
httpsServer = https.createServer credentials, app

# Start server
httpServer.listen config.get('http').port, ->
  console.log 'Express server listening on port %d in %s mode', config.get('http').port, app.settings.env

httpsServer.listen config.get('https').port, ->
  console.log 'Express server listening on port %d in %s mode', config.get('https').port, app.settings.env
