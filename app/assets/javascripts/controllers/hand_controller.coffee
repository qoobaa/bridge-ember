@Bridge.HandController = Ember.ArrayController.extend
  needs: ["board"]
  playedBinding: "controllers.board.cards"
  currentDirectionBinding: "controllers.board.play.currentDirection"
  currentSuitBinding: "controllers.board.play.currentSuit"
  hasCurrentSuit: (-> @get("remaining").findProperty("suit", @get("currentSuit"))?).property("currentSuit", "remaining")
  remaining: (->
    @get("initial").reject((card) => @get("played").findProperty("card", card)?).map(Bridge.Card.wrap)
  ).property("initial.@each", "played.@each")

  content: (->
    if @get("initial.length")
      cards = @get("initial").reject (card) => @get("played").findProperty("card", card)?
      cards.map (card) =>
        Bridge.Card.create
          hand: @
          currentSuitBinding: "hand.currentSuit"
          currentDirectionBinding: "hand.currentDirection"
          hasCurrentSuitBinding: "hand.hasCurrentSuit"
          directionBinding: "hand.direction"
          card: card
    else
      n = 13 - @get("played").filterProperty("direction.direction", @get("direction.direction")).get("length")
      if n > 0 then Card.create() for i in [1..n] else []
  ).property("initial.@each", "played.@each")

  play: (card) ->
    @get("controllers.board.state.cards").pushObject(card.get("card"))

Bridge.register "controller:hand_n", Bridge.HandController.extend
  initialBinding: "controllers.board.state.n"
  direction: Bridge.Direction.create(direction: "N")

Bridge.register "controller:hand_e", Bridge.HandController.extend
  initialBinding: "controllers.board.state.e"
  direction: Bridge.Direction.create(direction: "E")

Bridge.register "controller:hand_s", Bridge.HandController.extend
  initialBinding: "controllers.board.state.s"
  direction: Bridge.Direction.create(direction: "S")

Bridge.register "controller:hand_w", Bridge.HandController.extend
  initialBinding: "controllers.board.state.w"
  direction: Bridge.Direction.create(direction: "W")
