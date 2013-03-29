@Bridge.HandCardView = Bridge.CardView.extend
  isDisabled: (->
    @get("card.content") == "" or
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("card.suit") and @get("context.hasCardInCurrentSuit"))
  ).property("content", "context.isCompleted", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").playCard(@get("card")) unless @get("isDisabled")
