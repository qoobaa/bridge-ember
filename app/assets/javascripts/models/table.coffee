userSetter = (key, value) ->
  if arguments.length == 2
    if not value? or value instanceof Bridge.User then value else Bridge.User.create(value)

@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")

  user_n: (userSetter).property()
  user_e: (userSetter).property()
  user_s: (userSetter).property()
  user_w: (userSetter).property()

  currentUser: (->
    currentDirection = @get("board.currentDirection")
    @get("user_#{currentDirection.toLowerCase()}") if currentDirection
  ).property("board.currentDirection", "user_n", "user_e", "user_s", "user_w")

  declarerUser: (->
    declarer = @get("board.play.declarer")
    @get("user_#{declarer.toLowerCase()}") if declarer
  ).property("board.play.declarer", "user_n", "user_e", "user_s", "user_w")

  board: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.Board
        value
      else
        Bridge.Board.create(value)
  ).property()

  reload: ->
    $.ajax("/api/tables/#{@get('id')}")
    .done (payload) =>
      @setProperties(payload.table)

  save: ->
    $.ajax "/api/tables",
      type: "POST"
    .done (payload) =>
      @setProperties(payload.table)

  join: (direction) ->
    $.ajax "/api/tables/#{@get('id')}/join",
      type: "PATCH"
      data: table: {direction: direction}
    .done =>
      @set("user_#{direction.toLowerCase()}", id: Bridge.get("session.userId"))
