@Bridge.ContractLevelView = Ember.View.extend
  attributeBindings: ["disabled"]
  templateName: "contract_level"
  tagName: "button"
  disabled: (->
    false
  ).property()
