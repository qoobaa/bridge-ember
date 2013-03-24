@Bridge.ClaimView = Ember.View.extend
  classNames: ["form-inline"]
  classNameBindings: ["hidden"]
  templateName: "claim/claim"
  tagName: "form"

  hidden: (->
    not @get("context.declarer") or
    @get("direction") == @get("context.dummy") or
    not not @get("context.claimed")
  ).property("context.claimed", "context.dummy", "context.declarer")

  # Helper {{action}} somehow doesn't work
  submit: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @get("context").claim("#{@get('value')}#{@get('direction')}")
