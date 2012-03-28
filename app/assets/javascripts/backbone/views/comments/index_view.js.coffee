RailsBackboneRelational.Views.Comments ||= {}

class RailsBackboneRelational.Views.Comments.IndexView extends Backbone.View
  template: JST["backbone/templates/comments/index"]

  initialize: () ->
    @options.comments.bind('reset', @addAll)

  addAll: () =>
    @options.comments.each(@addOne)

  addOne: (comment) =>
    view = new RailsBackboneRelational.Views.Comments.CommentView({model : comment})
    @$("ul").append(view.render().el)

  render: =>
    $(@el).html(@template(comments: @options.comments.toJSON() ))
    @addAll()

    return this
