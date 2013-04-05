@Bridge.Table = Ember.Object.extend
  name: (-> "Table #{@get('id')}").property("id")

  user_n: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.User
        value
      else
        Bridge.User.create(value)
  ).property()

  user_e: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.User
        value
      else
        Bridge.User.create(value)
  ).property()

  user_s: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.User
        value
      else
        Bridge.User.create(value)
  ).property()

  user_w: ((key, value) ->
    if arguments.length == 2
      if not value? or value instanceof Bridge.User
        value
      else
        Bridge.User.create(value)
  ).property()

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
