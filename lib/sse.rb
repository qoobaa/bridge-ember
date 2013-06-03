class SSE
  def initialize(io)
    @io = io
  end

  def write(object, options = {})
    options.each { |key, value| @io.write("#{key}: #{value}\n") }
    @io.write("data: #{object.to_json}\n\n")
  end

  def close
    @io.close
  end
end
