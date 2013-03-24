@Bridge.ClaimController = Ember.Controller.extend
  needs: ["board"]

  acceptedDirections: []
  rejectedDirections: []
  claimed: undefined # example: "12E", "2N"

  declarerBinding: "controllers.board.declarer"
  dummyBinding: "controllers.board.dummy"
  lhoBinding: "controllers.board.lho"
  rhoBinding: "controllers.board.rho"

  finishedTricks: (->
    @get("controllers.board.tricks").reject (trick) -> trick.length != 4
  ).property("controllers.board.tricks.@each")

  max: (->
    13 - @get("finishedTricks").length
  ).property("finishedTricks.@each")

  isAccepted: (->
    return unless @get("acceptConditionDirections")
    @get("acceptConditionDirections").every (direction) => @get("acceptedDirections").contains(direction)
  ).property("acceptedDirections.@each")

  isRejected: (->
    return true if @get("rejectedDirections").length > 0
  ).property("rejectedDirections.@each")

  acceptConditionDirections: (->
    switch @get("claimed")?[-1..-1]
      when @get("declarer") then [@get("lho"), @get("rho")]
      when @get("lho"), @get("rho") then [@get("declarer")]
  ).property("claimed")

  claimAcceptedObserver: (->
    if @get("isAccepted")
      console.log("accepted")
  ).observes("isAccepted")

  claimRejectedObserver: (->
    if @get("isRejected")
      @set("claimed", undefined)
      @set("acceptedDirections", [])
      @set("rejectedDirections", [])
  ).observes("isRejected")

  claim: (claimed) ->
    @set("claimed", claimed)

  accept: (direction) ->
    @get("acceptedDirections").pushObject(direction)

  reject: (direction) ->
    @get("rejectedDirections").pushObject(direction)
