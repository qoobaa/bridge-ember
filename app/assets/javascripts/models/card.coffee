@Bridge.Card = Ember.Object.extend
  suit: (-> @get("card")?[0]).property("card")
  value: (-> @get("card")?[1]).property("card")
  order: (-> Bridge.CARDS.indexOf(@get("card")) % 13).property("card")

  currentDirectionBinding: "play.currentDirection"

  isEnabled: (->
    @get("card")? and @get("currentDirection.direction") == @get("direction.direction")
  ).property("currentDirection", "direction")
  isDisabled: (-> not @get("isEnabled")).property("isEnabled")
