@Bridge.BoardController = Ember.Controller.extend
  bids: []
  cards: []
  # http://slzbs.pl/protokoly//01/chorzow/13/1kwartal/mch0304002.html
  dealer: "E"
  n: ["C2", "CQ", "CK", "D9", "DT", "DJ", "H2", "H6", "H7", "S4", "S6", "S9", "SA"]
  # n: ["", "", "", "", "", "", "", "", "", "", "", "", ""]
  e: ["C4", "C5", "C7", "CT", "D3", "D5", "DQ", "H9", "HA", "S2", "S3", "S5", "S7"]
  s: ["D2", "D6", "D8", "DA", "H3", "H8", "HT", "HJ", "HQ", "HK", "S8", "SJ", "SQ"]
  w: ["C3", "C6", "C8", "C9", "CJ", "CA", "D4", "D7", "DK", "H4", "H5", "ST", "SK"]

  isAuctionCompleted: (->
    bids = @get("bids")
    length = bids.get("length")
    length > 3 and bids.slice(length - 3).every((bid) -> bid == "PASS")
  ).property("bids.@each")

  auctionDirections: (->
    Bridge.Utils.auctionDirections(@get("dealer"), @get("bids").concat(""))
  ).property("dealer", "bids.@each")

  currentAuctionDirection: (->
    @get("auctionDirections.lastObject")
  ).property("auctionDirections.@each")

  incompletedContract: (->
    Bridge.Utils.auctionContract(@get("dealer"), @get("bids"))
  ).property("dealer", "bids.@each")

  contract: (->
    @get("incompletedContract") if @get("isAuctionCompleted")
  ).property("isAuctionCompleted")

  declarer: (-> @get("contract")?[-1..-1]).property("contract")

  dummy: (->
    return unless @get("declarer")
    index = (Bridge.DIRECTIONS.indexOf(@get("declarer")) + 2) % 4
    Bridge.DIRECTIONS[index]
  ).property("declarer")

  lho: (->
    return unless @get("declarer")
    index = (Bridge.DIRECTIONS.indexOf(@get("declarer")) + 1) % 4
    Bridge.DIRECTIONS[index]
  ).property("declarer")

  rho: (->
    return unless @get("declarer")
    index = (Bridge.DIRECTIONS.indexOf(@get("declarer")) + 3) % 4
    Bridge.DIRECTIONS[index]
  ).property("declarer")

  trump: (->
    if @get("contract")
      suit = @get("contract")[1..1]
      if suit == "N" then undefined else suit # NT
  ).property("contract")

  isPlayCompleted: (->
    @get("cards.length") == 52
  ).property("cards.@each")

  playDirections: (->
    declarer = @get("declarer")
    Bridge.Utils.playDirections(declarer, @get("trump"), @get("cards").concat("")) if declarer
  ).property("declarer", "trump", "cards.@each")

  currentPlayDirection: (->
    @get("playDirections.lastObject")
  ).property("playDirections.@each")

  currentPhase: (->
    if @get("isPlayCompleted")
      "completed"
    else if @get("isAuctionCompleted")
      "play"
    else
      "auction"
  ).property("isAuctionCompleted", "isPlayCompleted")

  currentDirection: (->
    switch @get("currentPhase")
      when "auction" then @get("currentAuctionDirection")
      when "play" then @get("currentPlayDirection")
  ).property("currentPhase", "currentAuctionDirection", "currentPlayDirection")

  score: (->
    return unless @get("isPlayCompleted")
    wonTricksNumber = switch @get("declarer")
      when "N", "S" then @get("snWonTricksNumber")
      when "E", "W" then @get("ewWonTricksNumber")
    Bridge.Utils.score(@get("contract"), wonTricksNumber)
  ).property("isPlayCompleted")

  scoreString: (->
    score = @get("score")
    switch
      when score == 0 then "="
      when score > 0  then "+#{score}"
      when score < 0  then String(score)
  ).property("score")

  # Play properties
  tricks: (->
    if @get("cards").get("length") > 0
      n = Math.ceil(@get("cards").get("length") / 4) - 1
      @get("cards").slice(i * 4, i * 4 + 4) for i in [0..n]
    else
      []
  ).property("cards.@each")

  isTrickLead: (->
    @get("cards").get("length") % 4 == 0
  ).property("cards.@each")

  currentSuit: (->
    @get("tricks.lastObject.firstObject")?[0] unless @get("isTrickLead")
  ).property("isTrickLead")

  snWonTricksNumber: (->
    @get("wonTrickCards").filter((card) => @get("s").contains(card) or @get("n").contains(card)).length
  ).property("wonTrickCards.@each")

  ewWonTricksNumber: (->
    @get("wonTrickCards").filter((card) => @get("e").contains(card) or @get("w").contains(card)).length
  ).property("wonTrickCards.@each")

  wonTrickCards: (->
    tricks = @get("tricks").reject (trick) -> trick.length != 4
    tricks.map (trick) => Bridge.Utils.trickWinner(trick, @get("trump"))
  ).property("tricks.@each")
