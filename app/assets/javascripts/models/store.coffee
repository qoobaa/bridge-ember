@Bridge.Store = Ember.Object.extend
  init: ->
    @_super.apply(@, arguments)
    @set("tables", Bridge.Tables.create(content: []))
    @get("tables").load()
