def redis
  return Thread.current[:redis] if Thread.current.key?(:redis)
  Thread.current[:redis] = Redis.new
end
