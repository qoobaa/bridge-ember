@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_accept"
  tagName: "button"

  hidden: (->
    @get("direction") == @get("context.dummy") or
    @get("direction") == @get("context.claimed")?[-1..-1] or
    not @get("context.claimed")
  ).property("context.claimed", "context.dummy")

  disabled: (->
    @get("context.acceptedDirections").contains(@get("direction"))
  ).property("context.acceptedDirections.@each")

  click: ->
    @get("context").accept(@get("direction"))
