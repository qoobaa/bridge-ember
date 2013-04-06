@Bridge.JoinView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  templateName: "join"
  tagName: "button"

  hide: (->
    @get("context.isSignedInUserAtTable") ||
    !!@get("context.user_#{@get('direction').toLowerCase()}")
  ).property("context.isSignedInUserAtTable", "context.user_n", "context.user_e", "context.user_s", "context.user_w")

  click: ->
    @get("context").join(@get("direction"))
