@Bridge.DoubleView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/double"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      not @get("context.contract") or
      @get("context.isDoubled") or
      @get("context.currentSide") == @get("context.contractSide")
  ).property("context.isCompleted", "context.isDoubled", "context.currentSide", "context.contractSide")
  click: -> @get("context").bid("X")
