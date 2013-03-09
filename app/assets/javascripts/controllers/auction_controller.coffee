@Bridge.AuctionController = Ember.ObjectController.extend
  needs: ["board"]
  contentBinding: "controllers.board.auction"

  contractInfo: (->
    if @get("isCompleted")
      [@get("contract.bid"), @get("modifier.bid"), @get("declarer.direction")].without(undefined).join("")
  ).property("@each")
