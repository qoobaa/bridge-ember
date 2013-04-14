@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_accept"
  tagName: "button"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    not @get("context.tricks") or
    not @get("context.acceptConditionDirections").contains(@get("direction"))
  ).property("context.tricks", "context.acceptConditionDirections.@each", "context.dummy", "context.signedInUserDirection")

  disabled: (->
    @get("context.isAccepted") or
    @get("context.accepted").contains(@get("direction"))
  ).property("context.accepted.@each", "context.isAccepted")

  click: ->
    @get("context").accept(@get("direction"))
