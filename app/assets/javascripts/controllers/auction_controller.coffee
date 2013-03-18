@Bridge.AuctionController = Ember.ObjectController.extend
  needs: ["board"]
  contentBinding: "controllers.board.auction"
