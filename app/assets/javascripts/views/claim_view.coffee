@Bridge.ClaimView = Ember.View.extend
  classNames: ["form-inline"]
  classNameBindings: ["hidden"]
  templateName: "claim"
  tagName: "form"

  hidden: (->
    not not @get("context.claimed")
  ).property("context.claimed")

  # FIXME: Helper {{action}} somehow doesn't work
  submit: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @get("context").claim(@get("direction"))
