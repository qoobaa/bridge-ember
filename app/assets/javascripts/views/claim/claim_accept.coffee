@Bridge.ClaimAcceptView = Ember.View.extend
  classNames: ["btn"]
  classNameBindings: ["hidden"]
  attributeBindings: ["disabled"]
  templateName: "claim/claim_accept"
  tagName: "button"

  hidden: (->
    not @get("context.claimed") or
    not @get("context.acceptConditionDirections").contains(@get("direction"))
  ).property("context.claimed", "context.acceptConditionDirections.@each")

  disabled: (->
    @get("context.isAccepted") or
    @get("context.acceptedDirections").contains(@get("direction"))
  ).property("context.acceptedDirections.@each", "context.isAccepted")

  click: ->
    @get("context").accept(@get("direction"))
