@Bridge.Play = Ember.ArrayProxy.extend
  objectAtContent: (index) ->
    if card = @get("content").objectAt(index)
      Bridge.Card.create(content: card, index: index)

  declarer: (->
    @get("contract")[-1..-1]
  ).property("contract")

  declarerIndex: (->
    Bridge.DIRECTIONS.indexOf(@get("declarer"))
  ).property("declarer")

  lho: (->
    Bridge.DIRECTIONS[(@get("declarerIndex") + 1) % 4]
  ).property("declarerIndex")

  trump: (->
    suit = @get("contract")[1..1]
    if suit == "N" then undefined else suit
  ).property("contract")

  tricks: (->
    if @get("length") > 0
      n = Math.ceil(@get("length") / 4) - 1
      Bridge.Trick.create(play: @, trumpBinding: "play.trump", content: @slice(i * 4, i * 4 + 4)) for i in [0..n]
    else
      []
  ).property("length")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  # currentDirection: (->
  #   @get("tricks.lastObject.winner.direction") or @get("lastObject.direction.next") or @get("lho")
  # ).property("lastObject.direction.next", "tricks.lastObject.winner.direction", "lho")
  # currentSuit: (->
  #   @get("tricks.lastObject.suit") unless @get("tricks.lastObject.isCompleted")
  # ).property("tricks.lastObject.suit", "tricks.lastObject.isCompleted")

  # contentDidChange: (->
  #   currentDirection = @get("declarer.next")
  #   @forEach (card, i) =>
  #     currentDirection = @get("tricks.#{Math.floor(i / 4) - 1}.winner.direction") if i > 0 and i % 4 == 0
  #     card.set("direction", currentDirection)
  #     currentDirection = currentDirection.get("next")
  # ).observes("@each", "tricks.@each.winner.direction", "trump", "declarer.next")
