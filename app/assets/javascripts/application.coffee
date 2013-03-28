#= require ./vendor/jquery
#= require ./vendor/handlebars
#= require ./vendor/ember
#= require_self
#= require bridge

@Bridge = Ember.Application.create()

Bridge.IndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    auction = Bridge.Auction.create(content: [], dealer: "N")
    play = Bridge.Play.create(content: [], contract: "4NTE")

    @controllerFor("hand_n").set("play", play)
    @controllerFor("hand_n").set("initial", ["C2", "CQ", "CK", "D9", "DT", "DJ", "H2", "H6", "H7", "S4", "S6", "S9", "SA"])
    @controllerFor("hand_e").set("play", play)
    @controllerFor("hand_e").set("initial", ["C4", "C5", "C7", "CT", "D3", "D5", "DQ", "H9", "HA", "S2", "S3", "S5", "S7"])
    @controllerFor("hand_s").set("play", play)
    @controllerFor("hand_s").set("initial", ["D2", "D6", "D8", "DA", "H3", "H8", "HT", "HJ", "HQ", "HK", "S8", "SJ", "SQ"])
    @controllerFor("hand_w").set("play", play)
    @controllerFor("hand_w").set("initial", ["C3", "C6", "C8", "C9", "CJ", "CA", "D4", "D7", "DK", "H4", "H5", "ST", "SK"])
