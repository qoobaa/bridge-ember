@Bridge.Card = Ember.Object.extend
  value: (-> @get("content")[1]).property("content")
  suit: (-> @get("content")[0]).property("content")
  side: (-> if /N|S/.test(@get("direction")) then "NS" else "EW").property("direction")
