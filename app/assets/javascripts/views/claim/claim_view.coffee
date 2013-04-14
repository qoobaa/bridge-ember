@Bridge.ClaimView = Ember.View.extend
  classNames: ["form-inline"]
  classNameBindings: ["hide"]
  templateName: "claim/claim"
  tagName: "form"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    !@get("context.isResolved")
  ).property("context.isResolved", "context.dummy", "context.signedInUserDirection")

  claim: ->
    @get("context").claim(@get("value"), @get("direction"))
