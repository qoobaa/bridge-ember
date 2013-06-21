Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: ->
    Bridge.Tables.create(content: [])

  activate: ->
    stream = @controllerFor("stream")
    stream.connect("/stream/tables")
    stream.on("init", @, @setTables)
    stream.on("tableCreated", @, @mergeTable)
    stream.on("tableUpdated", @, @mergeTable)

  deactivate: ->
    stream = @controllerFor("stream")
    stream.disconnect()
    stream.off("init", @, @setTables)
    stream.off("tableCreated", @, @mergeTable)
    stream.off("tableUpdated", @, @mergeTable)

  setTables: (payload) ->
    @modelFor("index").set("content", payload)

  mergeTable: (payload) ->
    @modelFor("index").merge(payload.table)

  removeTable: (payload) ->
    @modelFor("index").remove(payload.table)
