Bridge.Router.map ->
  @route("signIn", path: "/sign_in")
  @resource("tables", path: "/tables")
  @resource("table", path: "/tables/:table_id")
