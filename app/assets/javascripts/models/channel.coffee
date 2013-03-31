@Bridge.Channel = Ember.Object.extend Ember.Evented,
  url: ""
  name: null
  isConnected: false
  isConnecting: false
  isOpen: false
  isReconnecting: false
  isRegistering: false
  isRegistered: false

  init: ->
    @io = io.connect(@get("url"), "auto connect": false)
    @io.on("message", (m) => @trigger(m.event, m.data))

    events = [
      "connect", "connecting", "connect_failed", "close",
      "disconnect", "reconnect", "reconnecting", "reconnect_failed",
      "error"
    ]

    @io.socket.on(event, => @socketStateDidChange()) for event in events
    @io.socket.on("error", (error) => @trigger("error", "unable to connect socket"))

  socketStateDidChange: ->
    @setProperties
      name: if @io.socket.connected then @io.socket.sessionid else null
      isConnected: @io.socket.connected
      isConnecting: @io.socket.connecting
      isOpen: @io.socket.open
      isReconnecting: @io.socket.reconnecting

  nameDidChange: (->
    @set("isRegistered", false)
    return unless @get("name")
    @set("isRegistering", true)
    $.ajax "/api/channel",
      success: =>
        @setProperties(isRegistered: true, isRegistering: false)
      error: =>
        @set("isRegistering", false)
        @trigger("error", "unable to register communication channel")
      type: "POST"
      data: {channel: {name: @get("name")}}
  ).observes("name")

  connect: ->
    @io.socket.disconnect()
    @io.socket.connect()

  disconnect: ->
    @io.socket.disconnect()
