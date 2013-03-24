@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  attributeBindings: ["disabled"]
  templateName: "claim_accept"
  tagName: "button"

  hidden: (->
    not @get("context.claimed")
  ).property("context.claimed")

  disabled: (->
    @get("context.acceptedDirections").contains(@get("direction"))
  ).property("context.acceptedDirections.@each")

  click: ->
    @get("context").accept(@get("direction"))
