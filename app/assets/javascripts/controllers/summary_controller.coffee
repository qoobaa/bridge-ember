@Bridge.SummaryController = Ember.Controller.extend
  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.isCompleted")

  winningCards: (->
    @get("play").filterProperty("isWinning")
  ).property("play.@each.isWinning")

  nsWonTricksNumber: (->
    @get("winningCards").filterProperty("side", "NS").length
  ).property("winningCards.@each")

  ewWonTricksNumber: (->
    @get("winningCards").filterProperty("side", "EW").length
  ).property("winningCards.@each")
