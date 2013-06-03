class SSE
  def initialize(io)
    @io = io
  end

  def write(object, options = {})
    options.each { |key, value| @io.write("#{key}: #{value}\n") }
    data = object.kind_of?(String) ? object : object.to_json
    @io.write("data: #{data}\n\n")
  end

  def close
    @io.close
  end
end
