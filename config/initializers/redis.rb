def redis
  return Thread.current[:redis] if Thread.current.key?(:redis)
  db = Rails.env.test? ? 1 : 0
  Thread.current[:redis] = Redis.new(db: db)
end

# message should contain: event, data
def redis_publish(channel: "lobby", **message)
  redis.publish(channel, message.to_json)
end
