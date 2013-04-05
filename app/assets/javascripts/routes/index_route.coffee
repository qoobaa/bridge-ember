Bridge.IndexRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("env.userId")

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
    @controllerFor("index").get("content").merge(payload.table)

  removeTable: (payload) ->
    @controllerFor("index").get("content").remove(payload.table)
