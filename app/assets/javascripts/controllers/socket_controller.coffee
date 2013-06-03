@Bridge.SocketController = Ember.ObjectController.extend
  init: ->
    @set "content", Ember.Object.create()
