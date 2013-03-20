@Bridge.CardView = Ember.View.extend
  classNameBindings: ["isPlayed:hidden"]
  attributeBindings: ["disabled"]
  templateName: "card"
  tagName: "button"

  isPlayed: (->
    @get("context.playedCards").contains(@get("content"))
  ).property("context.playedCards.@each")

  # TODO: simplify
  disabled: (->
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("content")[0] and @get("context.hasCardInCurrentSuit"))
  ).property("context.isCompleted", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").play(@get("content"))
