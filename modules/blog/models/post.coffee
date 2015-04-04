mongoose = require 'mongoose'

Entity = require '../../system/models/Entity'
Tag = require './Tag.coffee'

Post = new Entity
  title:  type: String, required: true
  teaser: type: String, required: true
  body:   type: String, required: true
  status: type: Boolean, default: false
  slug:   type: String, required: true, unique: true
  tags:   [type: mongoose.Schema.Types.ObjectId, ref: 'Tag']

module.exports = mongoose.model 'Post', Post
