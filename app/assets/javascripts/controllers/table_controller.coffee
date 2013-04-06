@Bridge.TableController = Ember.ObjectController.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "direction", "summary", "auction"]

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")
