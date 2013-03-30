@Bridge.Board = Ember.Object.extend
  playContractObserver: (->
    @get("play").set("contract", @get("auction.contract")) if @get("auction.isCompleted") and @get("auction.contract")
  ).observes("auction.isCompleted")
