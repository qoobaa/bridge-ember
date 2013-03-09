@Bridge.Play = Ember.ArrayProxy.extend
  tricks: (->
    if @get("length") > 0
      n = Math.ceil(@get("length") / 4) - 1
      Bridge.Trick.create(play: @, trumpBinding: "play.trump", content: @slice(i * 4, i * 4 + 4)) for i in [0..n]
    else
      []
  ).property("@each")
  isCompleted: (-> @get("length") == 52).property("@each")
  currentDirection: (->
    @get("tricks.lastObject.winner.direction") or @get("lastObject.direction.next") or @get("declarer.next")
  ).property("@each", "tricks", "declarer")

  contentDidChange: (->
    currentDirection = @get("declarer.next")
    @forEach (card, i) =>
      currentDirection = @get("tricks.#{Math.floor(i / 4) - 1}.winner.direction") if i > 0 and i % 4 == 0
      card.set("direction", currentDirection)
      currentDirection = currentDirection.get("next")
  ).observes("@each", "tricks", "trump", "declarer")
