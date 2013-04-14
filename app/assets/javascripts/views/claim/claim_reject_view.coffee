@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_reject"
  tagName: "button"

  hide: (->
    @get("context.isRejected") or
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    not @get("context.tricks") or
    @get("context.isResolved")
  ).property("context.isRejected", "context.tricks", "context.dummy", "context.signedInUserDirection", "context.isResolved")

  disabled: (->
    @get("context.isAccepted") or @get("context.isRejected")
  ).property("context.isAccepted", "context.isRejected")

  click: ->
    @get("context").reject(@get("direction"))
