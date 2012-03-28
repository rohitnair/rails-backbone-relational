class RailsBackboneRelational.Models.Comment extends Backbone.RelationalModel
  paramRoot: 'comment'

  defaults:
    content: null

class RailsBackboneRelational.Collections.CommentsCollection extends Backbone.Collection
  model: RailsBackboneRelational.Models.Comment
  url: '/comments'
  localStorage: new Backbone.LocalStorage("CommentsCollection")
