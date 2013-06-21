Bridge.TableRoute = Ember.Route.extend
  redirect: ->
    @transitionTo "signIn" unless Bridge.get("session.isSignedIn")

  model: (params) ->
    Bridge.Table.create(id: params.table_id)

  serialize: (model) ->
    table_id: model.get("id")

  activate: ->
    stream = @controllerFor("stream")
    stream.connect("/stream/tables/#{@modelFor('table').get('id')}")
    stream.on("init", @, @setTable)
    stream.on("tableCreated", @, @updateTable)
    stream.on("tableJoined", @, @updateTable)
    # stream.on("bids/create", @, @createBid)
    # stream.on("cards/create", @, @createCard)
    # stream.on("table/update", @, @updateTable)
    # stream.on("board/update", @, @updateBoard)
    # stream.on("claim/update", @, @updateClaim)

  deactivate: ->
    stream = @controllerFor("stream")
    stream.disconnect()
    stream.off("init", @, @setTable)
    stream.off("tableCreated", @, @updateTable)
    stream.off("tableJoined", @, @updateTable)
    # stream.off("bids/create", @, @createBid)
    # stream.off("cards/create", @, @createCard)
    # stream.off("table/update", @, @updateTable)
    # stream.off("board/update", @, @updateBoard)
    # stream.off("claim/update", @, @updateClaim)

  setTable: (payload) ->
    @modelFor("table").setProperties(payload.table)

  createBid: (payload) ->
    @modelFor("table").get("board.auction")?.pushObject(payload.bid.content)

  createCard: (payload) ->
    @modelFor("table").get("board.play")?.pushObject(payload.card.content)

  updateTable: (payload) ->
    @modelFor("table").setProperties(payload.table)

  updateBoard: (payload) ->
    @modelFor("table").get("board").setProperties(payload.board)

  updateClaim: (payload) ->
    @modelFor("table").get("board.claim").setProperties(payload.claim)
