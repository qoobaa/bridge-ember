@Bridge.ClaimRejectView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  templateName: "claim_reject"
  tagName: "button"

  hidden: (->
    not @get("context.claimed")
  ).property("context.claimed")

  click: ->
    @get("context").reject(@get("direction"))
