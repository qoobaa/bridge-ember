@Bridge.TrickController = Ember.ArrayController.extend
  trickNumberBinding: "play.lastObject.trick"

  dupa: (->
    @set("content", @get("play").filter((card) => card.get("trick") == @get("trickNumber")).mapProperty("content"))
  ).observes("play.@each", "trickNumber")
