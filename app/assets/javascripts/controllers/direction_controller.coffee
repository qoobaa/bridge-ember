@Bridge.DirectionController = Ember.Controller.extend
  current: (->
    if @get("auction.isCompleted") then @get("play.currentDirection") else @get("auction.currentDirection")
  ).property("auction.isCompleted", "auction.currentDirection", "play.currentDirection")
