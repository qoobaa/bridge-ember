@Bridge.Card = Ember.Object.extend
  suit: (-> @get("card")?[0]).property("card")
  value: (-> @get("card")?[0]).property("card")
