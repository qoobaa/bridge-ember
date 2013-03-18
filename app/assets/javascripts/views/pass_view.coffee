@Bridge.PassView = Ember.View.extend
  attributeBindings: ["disabled"]
  templateName: "pass"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted")
  ).property("context.isCompleted")
  click: -> @get("context").bid("PASS")
