@Bridge.Trick = Ember.ArrayProxy.extend
  reverseSortByOrder: (a, b) -> b.get("order") - a.get("order")

  winner: (->
    highestTrump = @filterProperty("suit", @get("trump")).sort(@reverseSortByOrder)[0]
    highestFirst = @filterProperty("suit", @get("firstObject.suit")).sort(@reverseSortByOrder)[0]
    highestTrump or highestFirst
  ).property("@each", "@each.card", "trump")
