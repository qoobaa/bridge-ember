@Bridge.AuctionController = Ember.ObjectController.extend
  needs: ["board"]
  contentBinding: "controllers.board.auction"

  contractString: (->
    [@get("contract.bid"), @get("modifier.bid"), @get("declarer.direction")].without(undefined).join("") if @get("isCompleted")
  ).property("isCompleted", "contract.bid", "modifier.bid", "declarer.direction")
