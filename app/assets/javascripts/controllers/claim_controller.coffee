@Bridge.ClaimController = Ember.Controller.extend
  needs: ["board"]

  finishedTricks: (->
    @get("controllers.board.tricks").reject (trick) -> trick.length != 4
  ).property("controllers.board.tricks.@each")

  max: (->
    13 - @get("finishedTricks").length
  ).property("finishedTricks.@each")

  isAcceptPossible: (->
    not not @get("claimed")
  ).property("claimed")

  claim: (direction) ->
    @set("claimed", [@get("value"), direction].join(""))
    console.log "claim"

  accept: (direction) ->
    console.log "accept #{direction}"

  reject: (direction) ->
    console.log "reject #{direction}"
