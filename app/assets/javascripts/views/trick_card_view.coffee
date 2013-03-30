@Bridge.TrickCardView = Bridge.CardView.extend
  classNameBindings: ["orderClassName"]

  orderClassName: (->
    "order-#{@get('card.index') % 4}" unless Ember.isNone(@get("card.index"))
  ).property("card.index")
