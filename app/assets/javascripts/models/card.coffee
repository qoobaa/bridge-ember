@Bridge.Card = Ember.Object.extend
  suit: (-> @get("content")?[0]).property("content")
  value: (-> @get("content")?[1]).property("content")
  order: (-> Bridge.CARDS.indexOf(@get("content")) % 13).property("content")

  isEnabled: (->
    @get("content")? and @get("currentDirection.direction") == @get("direction.direction") and (
      not @get("currentSuit")? or not @get("hasCurrentSuit") or @get("suit") == @get("currentSuit"))
  ).property("currentDirection", "currentSuit", "hasCurrentSuit", "direction")
  isDisabled: (-> not @get("isEnabled")).property("isEnabled")

@Bridge.Card.wrap = (content) -> Bridge.Card.create(content: content)
