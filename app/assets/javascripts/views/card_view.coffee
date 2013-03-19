@Bridge.CardView = Ember.View.extend
  classNameBindings: ["isPlayed:hidden"]
  attributeBindings: ["disabled"]
  templateName: "card"
  tagName: "button"

  isPlayed: (->
    @get("context.playedCards").contains(@get("content"))
  ).property("context.playedCards.@each")

  disabled: (->
    @get("context.isCompleted")# or @get("context.currentDirection") != @get("ownerDirection")
  ).property("context.isCompleted", "context.currentDirection")

  click: ->
    @get("context").play(@get("content"))
