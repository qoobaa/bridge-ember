@Bridge.AuctionController = Ember.ArrayController.extend
  content: []

  contract: (-> @filterProperty("isContract").get("lastObject")).property("@each", "@each.value")
  modifier: (-> @slice(@indexOf(c)).filterProperty("isModifier").get("lastObject") if c = @get("contract")).property("contract", "@each", "@each.value")
  isCompleted: (-> @get("length") > 3 and @slice(@get("length") - 3).everyProperty("isPass")).property("@each", "@each.value")
