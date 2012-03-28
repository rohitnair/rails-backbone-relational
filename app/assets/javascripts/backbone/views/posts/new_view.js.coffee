RailsBackboneRelational.Views.Posts ||= {}

class RailsBackboneRelational.Views.Posts.NewView extends Backbone.View
  template: JST["backbone/templates/posts/new"]

  events:
    "submit #new-post": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (post) =>
        view = new RailsBackboneRelational.Views.Posts.PostView({model : post})
        $("#posts-list").prepend(view.render().el)
        comments_view = new RailsBackboneRelational.Views.Comments.IndexView(comments: post.get('comments'))
        view.$(".comments").html(comments_view.render().el)
        new_comment_view = new RailsBackboneRelational.Views.Comments.NewView(collection: post.get('comments'))
        view.$(".new_comment").html(new_comment_view.render().el)
        $("#title").val('')

      error: (post, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
