@Bridge.RedoubleView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "redouble"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      not @get("context.isDoubled") or
      @get("context.isRedoubled") or
      @get("context.currentSide") != @get("context.contractSide")
  ).property("context.isCompleted", "context.isRedoubled", "context.currentSide", "context.contractSide")
  click: -> @get("context").bid("XX")
