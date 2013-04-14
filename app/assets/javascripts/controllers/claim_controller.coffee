@Bridge.ClaimController = Ember.ObjectController.extend
  needs: ["table"]

  # http://stackoverflow.com/questions/12502465/bindings-on-objectcontroller-ember-js
  signedInUserDirection: null
  signedInUserDirectionBinding: "controllers.table.signedInUserDirection"
  play: null
  playBinding: "controllers.table.board.play"
  declarer: null
  declarerBinding: "play.declarer"
  dummy: null
  dummyBinding: "play.dummy"
  lho: null
  lhoBinding: "play.lho"
  rho: null
  rhoBinding: "play.rho"

  init: ->
    @_super.apply(@, arguments)
    # TODO: bind to board claim
    @set("content", Bridge.Claim.create(accepted: [], rejected: []))

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
    @get("acceptConditionDirections").every (direction) => @get("accepted").contains(direction)
  ).property("accepted.@each")

  isRejected: (->
    @get("rejected").length > 0
  ).property("rejected.@each")

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
        accepted: []
        rejected: []
  ).observes("isRejected")

  # Reject claim by playing card
  cardPlayedObserver: (->
    # Will be handled by board
    @get("rejected").pushObject("?") if @get("tricks")
  ).observes("play.@each")

  claim: (value, direction) ->
    @setProperties(tricks: value, direction: direction)
    @get("content").save(@get("controllers.table.board.id"))

  accept: (direction) ->
    @get("accepted").pushObject(direction)
    @get("content").accept(@get("controllers.table.board.id"), direction)

  reject: (direction) ->
    @get("rejected").pushObject(direction)
    @get("content").reject(@get("controllers.table.board.id"), direction)
