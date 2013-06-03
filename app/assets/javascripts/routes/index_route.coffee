Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: ->
    Bridge.Tables.create(content: [])

  activate: ->
    stream = @controllerFor("stream")
    stream.connect("/stream/tables")
    stream.on("tables", @, @setTables)
    stream.on("tables/create", @, @mergeTable)
    stream.on("tables/update", @, @mergeTable)
    stream.on("tables/destroy", @, @removeTable)

  deactivate: ->
    stream = @controllerFor("stream")
    stream.disconnect()
    stream.off("tables", @, @setTables)
    stream.off("tables/create", @, @mergeTable)
    stream.off("tables/update", @, @mergeTable)
    stream.off("tables/destroy", @, @removeTable)

  setTables: (payload) ->
    @modelFor("index").set("content", payload)

  mergeTable: (payload) ->
    @modelFor("index").merge(payload.table)

  removeTable: (payload) ->
    @modelFor("index").remove(payload.table)
