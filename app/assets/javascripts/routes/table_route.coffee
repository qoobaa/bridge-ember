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
    stream.on("tableUpdated", @, @updateTable)
    stream.on("bidCreated", @, @createBid)
    stream.on("boardCreated", @, @updateBoard)
    stream.on("cardCreated", @, @createCard)
    stream.on("boardUpdated", @, @updateBoard)
    # stream.on("claim/update", @, @updateClaim)

  deactivate: ->
    stream = @controllerFor("stream")
    stream.disconnect()
    stream.off("init", @, @setTable)
    stream.off("tableCreated", @, @updateTable)
    stream.off("tableUpdated", @, @updateTable)
    stream.off("bidCreated", @, @createBid)
    stream.off("boardCreated", @, @updateBoard)
    stream.off("cardCreated", @, @createCard)
    stream.off("boardUpdated", @, @updateBoard)
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
