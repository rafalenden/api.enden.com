request = require 'request'
https = require 'https'
cheerio = require 'cheerio'

Project = require '../models/Project'

# Get multiple projects
exports.getProjects = (req, res) ->
  skip = 0
  limit = 0
  sortOption = -1

  if req.query.skip?
    skip = req.query.skip
    delete req.query.skip

  if req.query.limit?
    limit = req.query.limit
    delete req.query.limit

  if req.query.sort?
    sortOption = req.query.sort
    delete req.query.sort

  Project.find(req.query).sort(createdAt: sortOption).limit(limit).skip(skip).exec (err, projects) ->
    res.status(500).json err if err
    res.send projects: projects

# Add project
exports.addProject = (req, res) ->
  Project.create req.body, (err, savedProject) ->
    if err
      res.status(500).json err
      console.log err
    else res.status(200).json 'OK'

# Edit project
exports.editProject = (req, res) ->
  Project.findByIdAndUpdate req.params.id, req.body, (err, resource) ->
    if err
      res.status(500).json err
      console.log err
    else res.status(200).json 'OK' # if resource

# Delete project
exports.deleteProject = (req, res) ->
  Project.findByIdAndRemove req.params.id, (err) ->
    res.status(500).json err if err
    res.status(200).json 'OK'


# TEST

# TODO: Add here some future proof mechanism to retrieve content from cache (permanent) in case if HTML of drupal.org will change.
exports.test = (req, res) ->
  projects = [
    {
      id: 1
      name: 'Form Placeholder'
      url: 'https://www.drupal.org/project/form_placeholder'
      usage: 0
      downloads: 0
    }
    {
      id: 2
      name: 'Allegro'
      url: 'https://www.drupal.org/project/allegro'
      usage: 0
      downloads: 0
    }
    {
      id: 3
      name: 'Virtual Keyboard'
      url: 'https://www.drupal.org/project/virtual_keyboard'
      usage: 0
      downloads: 0
    }
  ]

  completed_requests = 0

  for project in projects
    request.get project.url, (error, response, body) ->
      if error or response.statusCode isnt 200
        res.status(response.statusCode).json error
      else
        $ = cheerio.load body

        for requestedProject, i in projects
          if requestedProject.url is response.request.href
            projects[i].usage = parseInt($('.project-info strong').text().replace(',', ''), 10)
            projects[i].downloads = parseInt($('.project-info li:nth-child(5)').text().replace(/Downloads: |,/g, ''), 10)
            break

      completed_requests++

      if completed_requests is projects.length
        res.status(200).json projects


#  res.status(200).json projects




#  for project, i in projects
#    request.get project.url, (error, response, body) ->
#      if error or response.statusCode isnt 200
#        res.status(response.statusCode).json error
#      else
#        result[i] = project
#
#        $ = cheerio.load body
#
#        console.log i
#        result[i].usage = $('.project-info strong').text()
#        result[i].downloads = $('.project-info li:nth-child(5)').text().replace('Downloads: ', '')

#  res.status(200).json result



