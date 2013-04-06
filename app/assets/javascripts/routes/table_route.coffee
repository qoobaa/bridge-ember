Bridge.TableRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")

  activate: ->
    tableId = @modelFor("table").get("id")
    Bridge.channel.on("tables/#{tableId}/bids/create", @, @createBid)
    Bridge.channel.on("tables/#{tableId}/cards/create", @, @createCard)

  deactivate: ->
    tableId = @modelFor("table").get("id")
    Bridge.channel.off("tables/#{tableId}/bids/create", @, @createBid)
    Bridge.channel.off("tables/#{tableId}/cards/create", @, @createCard)

  createBid: (payload) ->
    @modelFor("table").get("board.auction")?.pushObject(payload.bid.content)

  createCard: (payload) ->
    @modelFor("table").get("board.play")?.pushObject(payload.card.content)
