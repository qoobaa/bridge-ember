@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_reject"
  tagName: "button"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    not @get("context.tricks")
  ).property("context.tricks", "context.dummy", "context.signedInUserDirection")

  disabled: (->
    @get("context.isAccepted")
  ).property("context.isAccepted")

  click: ->
    @get("context").reject(@get("direction"))
