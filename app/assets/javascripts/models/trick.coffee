@Bridge.Trick = Ember.ArrayProxy.extend
  reverseSortByOrder: (a, b) -> b.get("order") - a.get("order")
  suitBinding: "firstObject.suit"

  winner: (->
    if @get("length") == 4
      highestTrump = @filterProperty("suit", @get("trump")).sort(@reverseSortByOrder)[0]
      highestFirst = @filterProperty("suit", @get("suit")).sort(@reverseSortByOrder)[0]
      highestTrump or highestFirst
  ).property("length", "suit", "trump")
