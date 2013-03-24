@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  templateName: "claim_reject"
  tagName: "button"

  hidden: (->
    @get("direction") == @get("context.dummy") or
    not @get("context.claimed")
  ).property("context.claimed", "context.dummy")

  click: ->
    @get("context").reject(@get("direction"))
