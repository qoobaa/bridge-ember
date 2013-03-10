@Bridge.Card = Ember.Object.extend
  suit: (-> @get("card")?[0]).property("card")
  value: (-> @get("card")?[1]).property("card")
  order: (-> Bridge.CARDS.indexOf(@get("card")) % 13).property("card")

  currentDirectionBinding: "play.currentDirection"
  currentSuitBinding: "play.currentSuit"
  hasCurrentSuit: false

  isEnabled: (->
    @get("card")? and @get("currentDirection.direction") == @get("direction.direction") and (
      not @get("currentSuit")? or not @get("hasCurrentSuit") or @get("suit") == @get("currentSuit"))
  ).property("currentDirection", "direction")
  isDisabled: (-> not @get("isEnabled")).property("isEnabled")
