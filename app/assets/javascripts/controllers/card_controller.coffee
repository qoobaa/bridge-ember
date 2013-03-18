@Bridge.CardController = Ember.Controller.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"

  play: (card) ->
    @get("controllers.board.cards").pushObject(card)
