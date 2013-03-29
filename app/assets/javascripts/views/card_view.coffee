@Bridge.CardView = Ember.View.extend
  classNames: ["card"]
  classNameBindings: ["isDisabled:disabled", "isClub:suit-c", "isDiamond:suit-d", "isHeart:suit-h", "isSpade:suit-s"]

  templateName: (->
    name = if @get("card.value") then @get("card.value").toLowerCase() else "unknown"
    "cards/#{name}"
  ).property("card.value")

  isClub:    (-> @get("card.suit") == "C").property("card.suit")
  isDiamond: (-> @get("card.suit") == "D").property("card.suit")
  isHeart:   (-> @get("card.suit") == "H").property("card.suit")
  isSpade:   (-> @get("card.suit") == "S").property("card.suit")

  symbol: (->
    switch @get("card.suit")
      when "C" then "&clubs;"
      when "D" then "&diams;"
      when "H" then "&hearts;"
      when "S" then "&spades;"
  ).property("card.suit")

  isDisabled: true
