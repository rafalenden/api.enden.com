app = exports = module.exports = do require 'express'

# resourceParser = require 'resource-parser'
# resources = resourceParser.parse()

resources = [
  {
    "name": "Blog",
    "description": "Get list of blog posts or create new ones.",
    "model": "blogPost",
    "endpoints": [
      {
        "name": "Get list of blog posts",
        "method": "GET",
        "auth": false,
        "input": [
          {
            "name": "limit", "required": false, "type": "integer", "defaultValue": 0,
            "description": "Controls limit of posts to return"
          },
          {
            "name": "offset", "required": false, "type": "integer", "defaultValue": 0,
            "description": "Controls offset of posts to return"
          }
        ],
        "output": [
          {
            "name": "limit", "required": false, "type": "integer", "defaultValue": 0,
            "description": "Controls limit of posts to return"
          },
          {
            "name": "offset", "required": false, "type": "integer", "defaultValue": 0,
            "description": "Controls offset of posts to return"
          }
        ]
      }
    ]
  }
]

# Display API documentation
app.get '/', (req, res) ->
  res.render '../modules/help/views/help', resources: resources

# Display API documentation
app.get '/help', (req, res) ->
  res.send resources: resources
