@Bridge.Card = Ember.Object.extend
  suit: (-> @get("content")[0]).property("content")
  value: (-> @get("content")[1]).property("content")
  order: (-> Bridge.CONTENTS.indexOf(@get("content")) % 13).property("content")
  directionIndex: (-> Bridge.DIRECTIONS.indexOf(@get("direction"))).property("direction")
  side: (-> Bridge.SIDES[@get("directionIndex") % 2]).property("directionIndex")

#   isEnabled: (->
#     @get("content")? and @get("currentDirection.direction") == @get("direction.direction") and (
#       not @get("currentSuit")? or not @get("hasCurrentSuit") or @get("suit") == @get("currentSuit"))
#   ).property("currentDirection", "currentSuit", "hasCurrentSuit", "direction")
#   isDisabled: (-> not @get("isEnabled")).property("isEnabled")
