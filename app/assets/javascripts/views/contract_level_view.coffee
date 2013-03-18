@Bridge.ContractLevelView = Ember.View.extend
  attributeBindings: ["disabled"]
  templateName: "contract_level"
  tagName: "button"
  disabled: (->
    @get("context.isCompleted") or
      Bridge.CONTRACTS.indexOf(@get("context.bareContract")) >= Bridge.CONTRACTS.indexOf(@get("level") + "NT")
  ).property("context.bareContract", "context.isCompleted", "level")
  click: -> @set("context.level", @get("level"))

