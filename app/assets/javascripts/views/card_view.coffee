@Bridge.CardView = Ember.View.extend
  classNameBindings: ["isPlayed:hidden"]
  attributeBindings: ["disabled"]
  templateName: "card"
  tagName: "button"

  isPlayed: (->
    @get("context.playedCards").contains(@get("content"))
  ).property("context.playedCards.@each")

  # Doesn't work when no cards in played suit
  disabled: (->
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection")  or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("content")[0])
  ).property("context.isCompleted", "context.currentDirection", "context.currentSuit")

  click: ->
    @get("context").play(@get("content"))
