@Bridge.CardController = Ember.Controller.extend
  needs: ["board"]

  playedCardsBinding: "controllers.board.cards"
  isCompletedBinding: "controllers.board.isPlayCompleted"
  currentDirectionBinding: "controllers.board.currentPlayDirection"

  play: (card) ->
    console.log @get("controllers.board.contract")
    console.log @get("controllers.board.trump")
    console.log @get("controllers.board.declarer")
    console.log @get("controllers.board.playDirections")
    @get("controllers.board.cards").pushObject(card)
