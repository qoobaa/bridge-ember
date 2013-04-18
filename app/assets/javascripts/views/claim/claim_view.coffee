@Bridge.ClaimView = Ember.View.extend
  classNames: ["form-inline"]
  classNameBindings: ["hide"]
  templateName: "claim/claim"
  tagName: "form"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    @get("context.isClaimed")
  ).property("context.isClaimed", "context.dummy", "context.signedInUserDirection")

  claim: ->
    return unless @get("value")
    @get("context").claim(@get("value"), @get("direction"))
