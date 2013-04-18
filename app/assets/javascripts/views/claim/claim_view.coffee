@Bridge.ClaimView = Ember.View.extend
  classNames: ["btn-group"]
  classNameBindings: ["hide"]
  templateName: "claim/claim"

  hide: (->
    @get("context.signedInUserDirection") != @get("direction") or
    @get("direction") == @get("context.dummy") or
    @get("context.isClaimed")
  ).property("context.isClaimed", "context.dummy", "context.signedInUserDirection")

  range: (->
    num for num in [0..@get("context.max")]
  ).property("context.max")
