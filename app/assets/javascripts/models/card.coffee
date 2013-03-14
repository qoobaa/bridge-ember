@Bridge.Card = Ember.Object.extend
  direction: (-> @get("content")[-1..-1]).property("content")
  card: (-> @get("content")[0..-2]).property("content")
  suit: (-> @get("card")[0]).property("card")
  value: (-> @get("card")[1]).property("card")
  order: (-> Bridge.CARDS.indexOf(@get("card")) % 13).property("card")

#   isEnabled: (->
#     @get("content")? and @get("currentDirection.direction") == @get("direction.direction") and (
#       not @get("currentSuit")? or not @get("hasCurrentSuit") or @get("suit") == @get("currentSuit"))
#   ).property("currentDirection", "currentSuit", "hasCurrentSuit", "direction")
#   isDisabled: (-> not @get("isEnabled")).property("isEnabled")

@Bridge.Card.wrap = (content) -> Bridge.Card.create(content: content)
