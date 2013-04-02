@Bridge.Env = Ember.Object.extend
  init: ->
    @_super.apply(@, arguments)
    $("meta").each (i, element) =>
      @set($(element).attr("name").camelize(), $(element).attr("content"))

  csrfTokenDidChange: (->
    $.ajaxSettings.headers = {"X-CSRF-Token": @get("csrfToken")}
  ).observes("csrfToken")
