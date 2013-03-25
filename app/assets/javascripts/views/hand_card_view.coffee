@Bridge.HandCardView = Bridge.CardView.extend
  classNameBindings: ["isDisabled:disabled", "isClub:suit-c", "isDiamond:suit-d", "isHeart:suit-h", "isSpade:suit-s"]

  isDisabled: (->
    @get("content") == "" or
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("content")[0] and @get("context.hasCardInCurrentSuit"))
  ).property("content", "context.isCompleted", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").play(@get("content")) unless @get("isDisabled")
