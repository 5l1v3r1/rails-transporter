fs = require 'fs'
path = require 'path'

BaseFinderView = require './base-finder-view'

module.exports =
class SprocketsFinderView extends BaseFinderView
  populate: ->
    @displayFiles.length = 0
    
    editor = atom.workspace.getActiveEditor()
    dir = path.dirname(editor.getPath())
    line = editor.getCursor().getCurrentBufferLine()
    result = line.match(/require_tree\s*([a-zA-Z0-9_\-\./]+)\s*$/)
    
    for asset in fs.readdirSync(path.join(dir, result[1]))
      fullPath = path.join(dir, result[1], asset)
      stats = fs.statSync fullPath
      if stats.isFile()
        @displayFiles.push fullPath

    @setItems(@displayFiles)
