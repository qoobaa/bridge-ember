@Bridge.TrickController = Ember.Controller.extend
  trickNumberBinding: "play.lastObject.trick"

  n: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "N")?.get("content")
  ).property("trickNumber", "play.@each")

  e: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "E")?.get("content")
  ).property("trickNumber", "play.@each")

  s: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "S")?.get("content")
  ).property("trickNumber", "play.@each")

  w: (->
    @get("play").find((card) => card.get("trick") == @get("trickNumber") and card.get("direction") == "W")?.get("content")
  ).property("trickNumber", "play.@each")
