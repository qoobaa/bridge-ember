def redis
  return Thread.current[:redis] if Thread.current.key?(:redis)
  uri = URI.parse(ENV["REDIS_URL"].to_s)
  Thread.current[:redis] = Redis.new(host: uri.host, port: uri.port, password: uri.password)
end
