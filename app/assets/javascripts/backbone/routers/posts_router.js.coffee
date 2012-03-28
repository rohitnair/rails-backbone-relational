class RailsBackboneRelational.Routers.PostsRouter extends Backbone.Router
  initialize: (options) ->
    @posts = new RailsBackboneRelational.Collections.PostsCollection()
    @posts.reset options.posts

  routes:
    "/new"      : "newPost"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newPost: ->
    @view = new RailsBackboneRelational.Views.Posts.NewView(collection: @posts)
    $("#posts").html(@view.render().el)

  index: ->
    @view = new RailsBackboneRelational.Views.Posts.IndexView(posts: @posts)
    $("#posts").html(@view.render().el)

  show: (id) ->
    post = @posts.get(id)

    @view = new RailsBackboneRelational.Views.Posts.ShowView(model: post)
    $("#posts").html(@view.render().el)

  edit: (id) ->
    post = @posts.get(id)

    @view = new RailsBackboneRelational.Views.Posts.EditView(model: post)
    $("#posts").html(@view.render().el)
