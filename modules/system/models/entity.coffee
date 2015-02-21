{Schema} = require 'mongoose'

class Entity extends Schema
  constructor: ->
    Schema.apply this, arguments

    @add
      createdAt: type: Date, default: Date.now
      updatedAt: type: Date, default: Date.now

  test: ->
    console.log 'test'


module.exports = Entity
