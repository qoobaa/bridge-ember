@Bridge.TrickController = Ember.Controller.extend
  trickNumberBinding: "play.lastObject.trick"

  n: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "N")
  ).property("trickNumber", "play.@each")

  e: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "E")
  ).property("trickNumber", "play.@each")

  s: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "S")
  ).property("trickNumber", "play.@each")

  w: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "W")
  ).property("trickNumber", "play.@each")
