def redis
  return Thread.current[:redis] if Thread.current.key?(:redis)
  Thread.current[:redis] = Redis.new
end

def redis_publish(channel, message)
  redis.publish("bridge_#{Rails.env}/#{channel}", message.to_json)
end

def redis_subscribe(*channels, &block)
  (channels + ["service"]).map! { |channel| "bridge_#{Rails.env}/#{channel}" }
  redis.subscribe(*channels, &block)
end
