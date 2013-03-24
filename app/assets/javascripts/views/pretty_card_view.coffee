@Bridge.PrettyCardView = Ember.View.extend
  classNames: ["card"]
  classNameBindings: ["isDisabled:disabled", "isPlayed:hidden", "isClub:suit-c", "isDiamond:suit-d", "isHeart:suit-h", "isSpade:suit-s"]
  templateNameBinding: "templateName"

  templateName: (->
    name = if @get("content") == "" then "back" else @get("content")[1].toLowerCase()
    "cards/#{name}"
  ).property("content")

  isClub:    (-> @get("content")[0] == "C").property("content")
  isDiamond: (-> @get("content")[0] == "D").property("content")
  isHeart:   (-> @get("content")[0] == "H").property("content")
  isSpade:   (-> @get("content")[0] == "S").property("content")

  symbol: (->
    switch @get("content")[0]
      when "C" then "&clubs;"
      when "D" then "&diams;"
      when "H" then "&hearts;"
      when "S" then "&spades;"
  ).property("content")

  isPlayed: (->
    @get("context.playedCards").contains(@get("content"))
  ).property("context.playedCards.@each")

  # TODO: simplify
  isDisabled: (->
    @get("content") == "" or
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("content")[0] and @get("context.hasCardInCurrentSuit"))
  ).property("content", "context.isCompleted", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").play(@get("content")) unless @get("isDisabled")
