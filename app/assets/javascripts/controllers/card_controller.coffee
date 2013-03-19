@Bridge.CardController = Ember.Controller.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"
  currentSuitBinding: "controllers.board.currentSuit"

  play: (card) ->
    @get("controllers.board.cards").pushObject(card)
