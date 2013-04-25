@Bridge.TableView = Ember.View.extend
  directionBinding: "controller.signedInUserDirection"

  templateName: (->
    "table_#{@get('direction') or 'S'}".toLowerCase()
  ).property("direction")

  templateNameDidChange: (->
    @rerender()
  ).observes("templateName")
