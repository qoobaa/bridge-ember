@Bridge.AuctionController = Ember.ArrayController.extend
  needs: ["board"]
  contentBinding: "controllers.board.auction"
