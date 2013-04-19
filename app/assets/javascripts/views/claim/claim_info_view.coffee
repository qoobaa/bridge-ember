@Bridge.ClaimInfoView = Ember.View.extend
  classNames: ["alert alert-info"]
  templateName: "claim/claim_info"

  isVisible: (->
    @get("context.isClaimed")
  ).property("context.isClaimed")

