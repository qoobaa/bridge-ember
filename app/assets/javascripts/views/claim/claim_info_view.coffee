@Bridge.ClaimInfoView = Ember.View.extend
  classNameBindings: ["hide"]
  templateName: "claim/claim_info"

  hide: (->
    not @get("context.claimed")
  ).property("context.claimed")
