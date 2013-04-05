@Bridge.SummaryController = Ember.Controller.extend
  needs: ["table"]

  auctionBinding: "controllers.table.board.auction"
  playBinding: "controllers.table.board.play"
  dealerBinding: "controllers.table.board.dealer"
  vulnerableBinding: "controllers.table.board.vulnerable"


  contract: (->
    @get("auction.contract") if @get("auction.isCompleted")
  ).property("auction.isCompleted")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each.isWinning")

  nsWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "NS").length
  ).property("winningCards.@each")

  ewWonTricksNumber: (->
    @get("winningCards")?.filterProperty("side", "EW").length
  ).property("winningCards.@each")
