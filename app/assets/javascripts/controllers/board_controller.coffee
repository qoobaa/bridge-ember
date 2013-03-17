@Bridge.BoardController = Ember.ObjectController.extend
  bids: ["1C", "PASS", "2NT", "X"]
  cards: []
  dealer: "N"
  n: ["C2", "S3", "H4", "D5", "C6", "C7", "C8", "C9", "CT", "CJ", "CQ", "CK", "CA"]
  e: ["D2", "C3", "S4", "H5", "D6", "D7", "D8", "D9", "DT", "DJ", "DQ", "DK", "DA"]
  s: ["H2", "D3", "C4", "S5", "H6", "H7", "H8", "H9", "HT", "HJ", "HQ", "HK", "HA"]
  w: ["S2", "H3", "D4", "C5", "S6", "S7", "S8", "S9", "ST", "SJ", "SQ", "SK", "SA"]

  isAuctionCompleted: (->
    bids = @get("bids")
    length = bids.get("length")
    length > 3 and bids.slice(length - 3).everyProperty("isPass")
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
    @get("partialContract") if @get("isAuctionCompleted")
  ).property("incompletedContract", "isAuctionCompleted")

  declarer: (->
    @get("contract")[-1..-1] if @get("contract")
  ).property("contract")

  trump: (->
    if @get("contract")
      suit = @get("contract")[1..1]
      if suit == "N" then undefined else suit
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
