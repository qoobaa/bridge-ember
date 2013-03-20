@Bridge.IndexController = Ember.Controller.extend
  needs: ["auction", "bidding_box", "board", "hand_n", "hand_e", "hand_s", "hand_w"]
