RailsBackboneRelational.Views.Posts ||= {}

class RailsBackboneRelational.Views.Posts.IndexView extends Backbone.View
  template: JST["backbone/templates/posts/index"]

  initialize: () ->
    @options.posts.bind('reset', @addAll)

  addAll: () =>
    @view = new RailsBackboneRelational.Views.Posts.NewView(collection: @options.posts)
    $("#new_post").html(@view.render().el)
    @options.posts.each(@addOne)

  addOne: (post) =>
    view = new RailsBackboneRelational.Views.Posts.PostView({model : post})
    @$("#posts-list").prepend(view.render().el)
    comments_view = new RailsBackboneRelational.Views.Comments.IndexView(comments: post.get('comments'))
    view.$(".comments").html(comments_view.render().el)
    new_comment_view = new RailsBackboneRelational.Views.Comments.NewView(collection: post.get('comments'))
    view.$(".new_comment").html(new_comment_view.render().el)

  render: =>
    $(@el).html(@template(posts: @options.posts.toJSON() ))
    @addAll()

    return this
