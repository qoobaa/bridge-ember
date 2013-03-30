@Bridge.DirectionView = Ember.View.extend
  classNames: ["hand-direction"]
  classNameBindings: ["current"]
  templateName: "direction"
  tagName: "h3"

  current: (->
    @get("context.current") == @get("content")
  ).property("context.current")
