@Bridge.ClaimView = Ember.View.extend
  classNames: ["form-inline"]
  classNameBindings: ["hide"]
  templateName: "claim/claim"
  tagName: "form"

  hide: (->
    not @get("context.declarer") or
    @get("direction") == @get("context.dummy") or
    not not @get("context.claimed")
  ).property("context.claimed", "context.dummy", "context.declarer")

  # Helper {{action}} somehow doesn't work
  submit: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @get("context").claim("#{@get('value')}#{@get('direction')}")
