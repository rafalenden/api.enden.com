# Get single post
exports.isAuthenticated = (req, res) ->
  config = require 'config'
  graph = require 'fbgraph'
  graph.setAccessToken(config.facebook.accessToken);

  options =
    timeout: 3000
    pool:
      maxSockets: Infinity
    headers:
      connection: 'keep-alive'

  graph
  .setOptions(options)
  .get 'me?fields=id', (err, fbResponse) ->
    res.status(500).json err if err
    if fbResponse.id is config.facebook.adminUserId
      res.status(200).json isAuthenticated: true
    else
      res.status(401).json isAuthenticated: false
