@Bridge.Channel = Ember.Object.extend Ember.Evented,
  isConnected: false
  isConnecting: false
  isOpen: false
  isReconnecting: false

  init: ->
    @_super.apply(@, arguments)
    @ioDidChange()

  io: (->
    io.connect @get("url"),
      "auto connect": false
  ).property("url")

  ioWillChange: (->
    if io = @get("io")
      io.socket.disconnect()
      io.removeAllListeners()
      io.socket.removeAllListeners()
  ).observesBefore("io")

  ioDidChange: (->
    if io = @get("io")
      io.on("message", (m) => @trigger(m.event, m.data))

      events = [
        "connect", "connecting", "connect_failed", "close",
        "disconnect", "reconnect", "reconnecting", "reconnect_failed",
        "error"
      ]

      io.socket.on(event, => @socketStateDidChange()) for event in events
      io.socket.on("error", (error) => @trigger("error", "unable to connect socket"))
      io.socket.connect()
  ).observes("io")

  socketStateDidChange: ->
    if io = @get("io")
      @setProperties
        name: if io.socket.connected then io.socket.sessionid else null
        isConnected: io.socket.connected
        isConnecting: io.socket.connecting
        isOpen: io.socket.open
        isReconnecting: io.socket.reconnecting

  subscribe: (tableId) ->
    deferred = new $.Deferred()
    channelName = if tableId? then "tables/#{tableId}" else "lobby"
    @get("io").once("subscribed", (payload) -> deferred.resolve(payload))
    @get("io").emit("subscribe", channelName)
    deferred.promise()

  register: (tableId) ->
    $.ajax "/api/channel",
      type: "post"
      data: channel: {name: @get("name"), table_id: tableId}
