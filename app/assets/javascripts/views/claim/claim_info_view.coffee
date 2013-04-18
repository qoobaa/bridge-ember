@Bridge.ClaimInfoView = Ember.View.extend
  classNames: ["alert alert-info"]
  classNameBindings: ["hide"]
  templateName: "claim/claim_info"

  hide: (->
    !@get("context.isClaimed")
  ).property("context.isClaimed")
