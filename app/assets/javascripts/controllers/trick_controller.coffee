@Bridge.TrickController = Ember.ArrayController.extend
  dupa: (->
    trickNumber = @get("play.lastObject.trick")
    @set("content", @get("play").filter (card) => card.trick == trickNumber)
  ).observes("play.@each", "play.lastObject")
