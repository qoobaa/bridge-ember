@Bridge.ContractLevelView = Ember.View.extend
  classNames: ["btn"]
  attributeBindings: ["disabled"]
  templateName: "bidding_box/contract_level"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      Bridge.CONTRACTS.indexOf(@get("context.contractBid")) >= Bridge.CONTRACTS.indexOf(@get("level") + "NT")
  ).property("context.contractBid", "context.isCompleted", "level")
  click: -> @set("context.level", @get("level"))

