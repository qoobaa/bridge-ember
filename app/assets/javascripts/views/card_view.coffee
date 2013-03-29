@Bridge.CardView = Ember.View.extend
  classNames: ["card"]
  classNameBindings: ["isDisabled:disabled", "isClub:suit-c", "isDiamond:suit-d", "isHeart:suit-h", "isSpade:suit-s"]

  templateName: (->
    name = if @get("content") then @get("content")[1].toLowerCase() else "unknown"
    "cards/#{name}"
  ).property("content")

  templateNameDidChange: (->
    @rerender()
  ).observes("templateName")

  isClub:    (-> @get("content")?[0] == "C").property("content")
  isDiamond: (-> @get("content")?[0] == "D").property("content")
  isHeart:   (-> @get("content")?[0] == "H").property("content")
  isSpade:   (-> @get("content")?[0] == "S").property("content")

  symbol: (->
    switch @get("content")?[0]
      when "C" then "&clubs;"
      when "D" then "&diams;"
      when "H" then "&hearts;"
      when "S" then "&spades;"
  ).property("content")

  isDisabled: true
