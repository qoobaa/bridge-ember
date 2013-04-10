def redis
  return Thread.current[:redis] if Thread.current.key?(:redis)
  Thread.current[:redis] = Redis.new
end

# message should contain: event, data
def redis_publish(channel: "tables", **message)
  redis.publish("#{Rails.env}/#{channel}", message.to_json)
end
