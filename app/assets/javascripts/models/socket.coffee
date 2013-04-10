@Bridge.Socket = Ember.Deferred.extend
  init: ->
    @_super.apply(@, arguments)
    @sock = new SockJS(Bridge.get("env.socketUrl"))
    @sock.onopen = => @resolve()
    @sock.onerror = => @reject()
