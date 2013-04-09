@Bridge.TableController = Ember.ObjectController.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "summary", "auction", "channel"]

  currentDirection: null
  currentDirectionBinding: "board.currentDirection"
  isChannelReady: null
  isChannelReadyBinding: "controllers.channel.isReady"

  contentDidChange: (->
    @get("content")?.reload() if @get("isChannelReady")
  ).observes("content", "isChannelReady")

  signedInUserDirection: (->
    @get("content").userDirection(Bridge.get("session.userId"))
  ).property("user_n", "user_e", "user_s", "user_w")

  join: (direction) ->
    @get("content").join(direction)

  quit: ->
    @get("content").quit()
