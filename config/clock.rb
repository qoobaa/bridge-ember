require "clockwork"
require_relative "boot"
require_relative "environment"

module Clockwork
  every(5.seconds, "service-ping") { redis_publish("service", event: "ping") }
end
