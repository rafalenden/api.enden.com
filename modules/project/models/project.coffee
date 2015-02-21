mongoose = require 'mongoose'

Entity = require '../../system/models/entity'

module.exports = mongoose.model 'Project', new Entity
  name:                type: String, required: true
  teaser:              type: String, required: true
  body:                type: String, required: true
  slug:                type: String, required: true, unique: true, lowercase: true
  url:                 type: String, required: true, unique: true
  usage:               type: Number, default: 0, min: 0
  downloads:           type: Number, default: 0, min: 0
  remoteDataUpdatedAt: type: Date, default: null
