@Bridge.Trick = Ember.ArrayProxy.extend
  reverseSortByOrder: (a, b) -> b.get("order") - a.get("order")
  suitBinding: "firstObject.suit"
  isCompleted: (-> @get("length") == 4).property("length")
  winner: (->
    if @get("isCompleted")
      highestTrump = @filterProperty("suit", @get("trump")).sort(@reverseSortByOrder)[0]
      highestFirst = @filterProperty("suit", @get("suit")).sort(@reverseSortByOrder)[0]
      highestTrump or highestFirst
  ).property("isCompleted", "suit", "trump")
