@Bridge.StreamController = Ember.Controller.extend Ember.Evented,
  isConnecting: (-> @get("readyState") == EventSource.CONNECTING).property("readyState")
  isOpen:       (-> @get("readyState") == EventSource.OPEN).property("readyState")
  isClosed:     (-> @get("readyState") == EventSource.CLOSED).property("readyState")

  update: -> @setProperties(readyState: eventSource?.readyState, url: eventSource?.url)

  connect: (url) ->
    @disconnect()
    eventSource = new EventSource(url)
    @set("eventSource", eventSource)
    eventSource.onopen = => @update()
    eventSource.onerror = => @update()
    eventSource.onmessage = (event) =>
      @update()
      payload = JSON.parse(event.data)
      @trigger(payload.event, payload.data)

  disconnect: ->
    @get("eventSource")?.close()
    @set("eventSource", undefined)
    @update()
