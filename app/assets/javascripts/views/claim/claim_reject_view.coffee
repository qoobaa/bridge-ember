@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hide"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_reject"
  tagName: "button"

  hide: (->
    !@get("context.isClaimed") or
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy")
  ).property("context.isClaimed", "context.dummy", "context.signedInUserDirection")

  disabled: (->
    @get("context.isAccepted") or @get("context.isRejected")
  ).property("context.isAccepted", "context.isRejected")

  click: ->
    @get("context").reject(@get("direction"))
