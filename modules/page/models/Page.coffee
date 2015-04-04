mongoose = require 'mongoose'

Entity = require '../../system/models/Entity'

Page = new Entity
  title:  type: String, required: true
  teaser: type: String, required: true
  body:   type: String, required: true
  status: type: Boolean, default: false
  slug:   type: String, required: true, unique: true

module.exports = mongoose.model 'Page', Page
