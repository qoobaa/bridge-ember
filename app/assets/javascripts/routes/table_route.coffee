Bridge.TableRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")

  setupController: (controller, model) ->
    # @controllerFor("channel").set("tableId", model.get("id"))

  activate: ->
    # channel = @controllerFor("channel").get("content")
    # channel.on("bids/create", @, @createBid)
    # channel.on("cards/create", @, @createCard)
    # channel.on("table/update", @, @updateTable)

  deactivate: ->
    # channel = @controllerFor("channel").get("content")
    # channel.off("bids/create", @, @createBid)
    # channel.off("cards/create", @, @createCard)
    # channel.off("table/update", @, @updateTable)

  createBid: (payload) ->
    @modelFor("table").get("board.auction")?.pushObject(payload.bid.content)

  createCard: (payload) ->
    @modelFor("table").get("board.play")?.pushObject(payload.card.content)

  updateTable: (payload) ->
    @modelFor("table").setProperties(payload.table)
