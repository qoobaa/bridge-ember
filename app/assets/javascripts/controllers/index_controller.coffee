@Bridge.IndexController = Ember.Controller.extend
  needs: ["auction", "bidding_box"]

  init: ->
    @_super.apply(@, arguments)
