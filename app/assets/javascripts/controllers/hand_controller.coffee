@Bridge.HandController = Ember.ArrayController.extend
  needs: ["board"]
  playedBinding: "controllers.board.cards"

  content: (->
    if @get("initial.length")
      @get("initial").reject (card) => @get("played").findProperty("card", card.get("card"))?
    else
      n = 13 - @get("played").filterProperty("direction.direction", @get("direction.direction")).get("length")
      if n > 0 then Bridge.Card.create() for i in [1..n] else []
  ).property("initial.@each", "played.@each")

  play: (card) ->
    @get("controllers.board.state.cards").pushObject(card.get("card"))

Bridge.register("controller:hand_n", Bridge.HandController.extend(initialBinding: "controllers.board.n"))
Bridge.register("controller:hand_e", Bridge.HandController.extend(initialBinding: "controllers.board.e"))
Bridge.register("controller:hand_s", Bridge.HandController.extend(initialBinding: "controllers.board.s"))
Bridge.register("controller:hand_w", Bridge.HandController.extend(initialBinding: "controllers.board.w"))
