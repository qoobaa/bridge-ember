Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: ->
    Bridge.Tables.create(content: [])

  setupController: (controller, model) ->
    # @controllerFor("channel").set("tableId", null)

  activate: ->
    # channel = @controllerFor("channel").get("content")
    # channel.on("tables/create", @, @mergeTable)
    # channel.on("tables/update", @, @mergeTable)
    # channel.on("tables/destroy", @, @removeTable)

  deactivate: ->
    # channel = @controllerFor("channel").get("content")
    # channel.off("tables/create", @, @mergeTable)
    # channel.off("tables/update", @, @mergeTable)
    # channel.off("tables/destroy", @, @removeTable)

  mergeTable: (payload) ->
    @modelFor("index").merge(payload.table)

  removeTable: (payload) ->
    @modelFor("index").remove(payload.table)
