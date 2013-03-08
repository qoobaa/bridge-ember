@Bridge.BoardController = Ember.ObjectController.extend
  init: ->
    @_super.apply(@, arguments)
    @set "content", Bridge.Board.create
      state:
        bids: []
        cards: []
        dealer: "N"
