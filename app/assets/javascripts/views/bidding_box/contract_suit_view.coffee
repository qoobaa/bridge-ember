@Bridge.ContractSuitView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/contract_suit"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      Bridge.CONTRACTS.indexOf(@get("context.bareContract")) >= Bridge.CONTRACTS.indexOf(@get("context.level") + @get("suit"))
  ).property("context.isCompleted", "context.bareContract", "context.level", "suit")
  click: -> @get("context").bid(@get("context.level") + @get("suit"))
