@Bridge.TableController = Ember.ObjectController.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "direction", "summary"]

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")

  isSignedInUserAtTable: (->
    [@get("user_n.id"), @get("user_e.id"), @get("user_s.id"), @get("user_w.id")].contains(Bridge.get("session.userId"))
  ).property("user_n", "user_e", "user_s", "user_w")

  join: (direction) ->
    @get("content").join(direction)
