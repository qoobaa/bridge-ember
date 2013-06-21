class Event
  class_attribute :channel_names
  self.channel_names = []

  def self.prefixed_channel(name)
    "bridge_#{Rails.env}_#{name}"
  end

  def self.channel(*names)
    self.channel_names = names.map { |name| prefixed_channel(name) }
  end

  def event_name
    self.class.name.demodulize.camelize(:lower)
  end

  def publish
    self.class.channel_names.each { |channel_name| redis.publish(channel_name, Marshal.dump(self)) }
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
end
