RailsBackboneRelational.Views.Comments ||= {}

class RailsBackboneRelational.Views.Comments.NewView extends Backbone.View
  template: JST["backbone/templates/comments/new"]

  events:
    "keypress .content": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    if e.keyCode == 13 and @$('.content').val() != ''
      @model.unset("errors")
      @model.set('content', @$('.content').val())

      @collection.create(@model.toJSON(),
        success: (comment) =>
          view = new RailsBackboneRelational.Views.Comments.CommentView({model : comment})
          $(@.el).parent().prev().find('.comments-list').append(view.render().el)
          @$('.content').val('')

        error: (comment, jqXHR) =>
          @model.set({errors: $.parseJSON(jqXHR.responseText)})
      )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    return this
