@Bridge.ClaimController = Ember.Controller.extend
  needs: ["table"]

  signedInUserDirectionBinding: "controllers.table.signedInUserDirection"
  playBinding: "controllers.table.board.play"
  declarerBinding: "play.declarer"
  dummyBinding: "play.dummy"
  lhoBinding: "play.lho"
  rhoBinding: "play.rho"

  acceptedDirections: []
  rejectedDirections: []

  isEnabled: (->
    !!@get("play.contract")
  ).property("play.contract")

  acceptConditionDirections: (->
    switch @get("direction")
      when @get("declarer") then [@get("lho"), @get("rho")]
      when @get("lho"), @get("rho") then [@get("declarer")]
  ).property("direction")

  isAccepted: (->
    return unless @get("acceptConditionDirections")
    @get("acceptConditionDirections").every (direction) => @get("acceptedDirections").contains(direction)
  ).property("acceptedDirections.@each")

  isRejected: (->
    @get("rejectedDirections").length > 0
  ).property("rejectedDirections.@each")

  winningCards: (->
    @get("play")?.filterProperty("isWinning")
  ).property("play.@each")

  max: (->
    13 - @get("winningCards")?.length || 0
  ).property("winningCards.@each")

  isAcceptedDidChange: (->
    console.log("accepted") if @get("isAccepted")
    # @get("controllers.board").set("claim", @get("tricks")) if @get("isAccepted")
  ).observes("isAccepted")

  claimRejectedObserver: (->
    if @get("isRejected")
      @setProperties
        tricks: undefined
        direction: undefined
        acceptedDirections: []
        rejectedDirections: []
  ).observes("isRejected")

  # Reject claim by playing card
  cardPlayedObserver: (->
    # Will be handled by board
    @get("rejectedDirections").pushObject("?") if @get("tricks")
  ).observes("play.@each")

  claim: (value, direction) ->
    @setProperties(tricks: value, direction: direction)

  accept: (direction) ->
    @get("acceptedDirections").pushObject(direction)

  reject: (direction) ->
    @get("rejectedDirections").pushObject(direction)
