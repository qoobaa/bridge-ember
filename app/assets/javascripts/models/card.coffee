@Bridge.Card = Ember.Object.extend
  suit: (-> @get("card")?[0]).property("card")
  value: (-> @get("card")?[0]).property("card")
  order: (-> Bridge.CARDS.indexOf(@get("card")) % 13).property("card")
