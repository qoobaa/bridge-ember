@Bridge.DoubleView = Ember.View.extend
  attributeBindings: ["disabled"]
  templateName: "double"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      not @get("context.contract") or
      @get("context.isDoubled") or
      @get("context.currentSide") == @get("context.contractSide")
  ).property("context.isCompleted", "context.isDoubled", "context.currentSide", "context.contractSide")
  click: -> @get("context").bid("X")
