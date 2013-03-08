@Bridge.Play = Ember.ArrayProxy.extend
  tricks: (->
    Bridge.Trick.create(play: @, trumpBinding: "play.trump", content: @slice(i * 4, i * 4 + 4)) for i in [0..12]
  ).property("@each")
