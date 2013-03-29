@Bridge.TrickController = Ember.ArrayController.extend
  dupa: (->
    trickNumber = @get("play.arrangedContent.lastObject.trick")
    console.log @get("play.arrangedContent.lastObject")
    @set("content", @get("play.arrangedContent").filter (card) => card.trick == trickNumber)
  ).observes("play.arrangedContent.@each")
