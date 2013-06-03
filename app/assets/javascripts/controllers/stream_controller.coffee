@Bridge.StreamController = Ember.Controller.extend Ember.Evented,
  uri: "/stream/tables"

  isConnecting: (-> @get("readyState") == EventSource.CONNECTING).property("readyState")
  isOpen: (-> @get("readyState") == EventSource.OPEN).property("readyState")
  isClosed: (-> @get("readyState") == EventSource.CLOSED).property("readyState")

  init: ->
    @connect()

  connect: ->
    @close()
    @set("readyState", undefined)
    eventSource = new EventSource(@get("uri"))
    @set("eventSource", eventSource)
    eventSource.onopen = => @set("readyState", eventSource.readyState)
    eventSource.onerror = => @set("readyState", eventSource.readyState)
    eventSource.onmessage = (event) =>
      @set("readyState", eventSource.readyState)
      payload = JSON.parse(event.data)
      @trigger(payload.event, payload.data)

  close: ->
    eventSource.close() if eventSource = @get("eventSource")

  readyStateDidChange: (->
    console.log(@get("readyState"))
  ).observes("readyState")
