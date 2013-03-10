@Bridge.Play = Ember.ArrayProxy.extend
  content: (-> @get("cards")?.map(Bridge.Card.wrap)).property("cards.@each")
  tricks: (->
    if @get("length") > 0
      n = Math.ceil(@get("length") / 4) - 1
      Bridge.Trick.create(play: @, trumpBinding: "play.trump", content: @slice(i * 4, i * 4 + 4)) for i in [0..n]
    else
      []
  ).property("length")
  isCompleted: (-> @get("length") == 52).property("length")
  currentDirection: (->
    @get("tricks.lastObject.winner.direction") or @get("lastObject.direction.next") or @get("declarer.next")
  ).property("lastObject.direction.next", "tricks.lastObject.winner.direction", "declarer.next")
  currentSuit: (->
    @get("tricks.lastObject.suit") unless @get("tricks.lastObject.isCompleted")
  ).property("tricks.lastObject.suit", "tricks.lastObject.isCompleted")

  contentDidChange: (->
    currentDirection = @get("declarer.next")
    @forEach (card, i) =>
      currentDirection = @get("tricks.#{Math.floor(i / 4) - 1}.winner.direction") if i > 0 and i % 4 == 0
      card.set("direction", currentDirection)
      currentDirection = currentDirection.get("next")
  ).observes("@each", "tricks.@each.winner.direction", "trump", "declarer.next")
