@Bridge.Board = Ember.Object.extend
  playContractObserver: (->
    @get("play").set("contract", @get("auction.contract")) if @get("auction.isCompleted")
  ).observes("auction.isCompleted")
