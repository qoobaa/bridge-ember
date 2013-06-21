class Event
  attr_accessor :current_user

  def self.prefixed_channel(name)
    "bridge_#{Rails.env}_#{name}"
  end

  def channel_names
    []
  end

  def publish
    channel_names.each { |name| redis.publish(self.class.prefixed_channel(name), Marshal.dump(self)) }
  end

  def event_name
    self.class.name.demodulize.camelize(:lower)
  end

  def as_json
    {event: event_name, data: data}
  end

  def self.subscribe(channel)
    channels = [prefixed_channel("service"), prefixed_channel(channel)]
    redis.subscribe(channels) do |on|
      on.message do |channel, payload|
        event = Marshal.load(payload) unless channel == prefixed_channel("service")
        yield event
      end
    end
  ensure
    redis.quit
  end

  def disconnect?
    false
  end
end
