@Bridge.CardView = Ember.View.extend
  classNameBindings: ["isPlayed:hidden"]
  attributeBindings: ["disabled"]
  templateName: "card"
  tagName: "button"

  isPlayed: (->
    @get("context.playedCards").contains(@get("content"))
  ).property("context.playedCards")

  disabled: (->
    @get("context.isCompleted")
  ).property("context.isCompleted")

  click: ->
    @get("context").play(@get("content"))

