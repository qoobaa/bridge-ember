@Bridge.QuitView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  templateName: "quit"
  tagName: "button"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction")
  ).property("context.signedInUserDirection")

  click: ->
    @get("context").quit(@get("direction"))
