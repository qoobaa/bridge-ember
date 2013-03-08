@Bridge.Trick = Ember.ArrayProxy.extend
  winner: (->
    highestTrump = @filterProperty("suit", @get("trump")).sort((a, b) -> b.get("order") - a.get("order"))[0]
    highestFirst = @filterProperty("suit", @get("firstObject.suit")).sort((a, b) -> b.get("order") - a.get("order"))[0]
    highestTrump or highestFirst
  ).property("@each", "@each.card", "trump")
