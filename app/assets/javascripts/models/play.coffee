@Bridge.Play = Ember.ArrayProxy.extend
  tricks: (->
    Bridge.Trick.create(play: @, trumpBinding: "play.trump", content: @slice(i * 4, i * 4 + 4)) for i in [0..12]
  ).property("@each")

  contentDidChange: (->
    currentDirection = @get("declarer.next")
    @forEach (card, i) =>
      currentDirection = @get("tricks.#{Math.floor(i / 4) - 1}.winner.direction") if i > 0 and i % 4 == 0
      card.set("direction", currentDirection)
      currentDirection = currentDirection.get("next")
  ).observes("@each", "tricks", "trump", "declarer")
