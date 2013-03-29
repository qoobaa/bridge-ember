@Bridge.Play = Ember.ArrayProxy.extend
  contract: ((key, value) ->
    if arguments.length == 2
      if value instanceof Bridge.Contract
        value
      else
        Bridge.Contract.create(content: value)
  ).property()

  trumpBinding: "contract.trump"
  declarerBinding: "contract.direction"

  init: ->
    @_super.apply(@, arguments)
    @reindex()

  reindex: (->
    Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat("")).forEach (direction, i, directions) =>
      if card = @get("content.#{i}")
        card.setProperties(index: i, direction: direction, isWinning: direction == directions[i + 1])
      else
        console.log(Ember.inspect(@get("declarer")))
        console.log(Ember.inspect(@get("trump")))
        console.log(Ember.inspect(@get("content")))
        console.log(Ember.inspect(Bridge.Utils.playDirections(@get("declarer"), @get("trump"), @get("content").concat(""))))
        @set("currentDirection", direction)
  ).observes("declarer", "trump", "content.@each")

  isCompleted: (->
    @get("length") == 52
  ).property("length")

  currentSuit: (->
    @filterProperty("isLead").get("lastObject.suit") if @get("length") % 4 != 0
  ).property("length", "content.@each")
