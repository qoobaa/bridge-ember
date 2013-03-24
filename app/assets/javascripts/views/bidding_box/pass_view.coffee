@Bridge.PassView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/pass"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted")
  ).property("context.isCompleted")
  click: -> @get("context").bid("PASS")
