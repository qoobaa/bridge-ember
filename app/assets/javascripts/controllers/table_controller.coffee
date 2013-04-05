@Bridge.TableController = Ember.Controller.extend
  needs: ["bidding_box", "hand_n", "hand_e", "hand_s", "hand_w", "trick", "direction", "summary"]

  contentDidChange: (->
    @get("content")?.reload()
  ).observes("content")
