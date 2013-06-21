require "clockwork"
require_relative "boot"
require_relative "environment"

module Clockwork
  every(5.seconds, "service-ping") { redis.publish("bridge_#{Rails.env}_service", "ping") }
end
