Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: ->
    Bridge.Tables.create(content: [])

  activate: ->
    Bridge.channel.on("tables/create", @, @mergeTable)
    Bridge.channel.on("tables/update", @, @mergeTable)
    Bridge.channel.on("tables/destroy", @, @removeTable)

  deactivate: ->
    Bridge.channel.off("tables/create", @, @mergeTable)
    Bridge.channel.off("tables/update", @, @mergeTable)
    Bridge.channel.off("tables/destroy", @, @removeTable)

  mergeTable: (payload) ->
    @modelFor("index").merge(payload.table)

  removeTable: (payload) ->
    @modelFor("index").remove(payload.table)
