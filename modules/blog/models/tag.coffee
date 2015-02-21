mongoose = require 'mongoose'

tagSchema = mongoose.Schema
  name: String

module.exports = mongoose.model 'Tag', tagSchema
