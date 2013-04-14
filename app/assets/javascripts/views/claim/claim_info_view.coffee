@Bridge.ClaimInfoView = Ember.View.extend
  classNameBindings: ["hide"]
  templateName: "claim/claim_info"

  hide: (->
    @get("context.isResolved")
  ).property("context.isResolved")
