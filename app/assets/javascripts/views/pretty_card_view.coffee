@Bridge.PrettyCardView = Ember.View.extend
  classNames: ["card"]
  classNameBindings: ["isDisabled:disabled", "isPlayed:hidden", "isClub:suit-c", "isDiamond:suit-d", "isHeart:suit-h", "isSpade:suit-s"]
  templateName: "pretty_card"

  isClub:    (-> @get("content")[0] == "C").property("content")
  isDiamond: (-> @get("content")[0] == "D").property("content")
  isHeart:   (-> @get("content")[0] == "H").property("content")
  isSpade:   (-> @get("content")[0] == "S").property("content")

  isBack: (-> @get("content") == "").property("content")
  is2: (-> @get("content")[1] == "2").property("content")
  is3: (-> @get("content")[1] == "3").property("content")
  is4: (-> @get("content")[1] == "4").property("content")
  is5: (-> @get("content")[1] == "5").property("content")
  is6: (-> @get("content")[1] == "6").property("content")
  is7: (-> @get("content")[1] == "7").property("content")
  is8: (-> @get("content")[1] == "8").property("content")
  is9: (-> @get("content")[1] == "9").property("content")
  isT: (-> @get("content")[1] == "T").property("content")
  isJ: (-> @get("content")[1] == "J").property("content")
  isQ: (-> @get("content")[1] == "Q").property("content")
  isK: (-> @get("content")[1] == "K").property("content")
  isA: (-> @get("content")[1] == "A").property("content")

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
    @get("isBack") or
    @get("context.isCompleted") or
    @get("context.currentDirection") != @get("ownerDirection") or
    (@get("context.currentSuit")? and @get("context.currentSuit") != @get("content")[0] and @get("context.hasCardInCurrentSuit"))
  ).property("isBack", "context.isCompleted", "context.currentDirection", "context.currentSuit", "context.hasCardInCurrentSuit")

  click: ->
    @get("context").play(@get("content")) unless @get("isDisabled")
