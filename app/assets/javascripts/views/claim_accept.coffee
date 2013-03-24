@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  templateName: "claim_accept"
  tagName: "button"

  hidden: (->
    not @get("context.claimed")
  ).property("context.claimed")

  click: ->
    @get("context").accept(@get("direction"))
