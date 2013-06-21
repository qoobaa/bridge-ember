class Event::TableCreated < Event
  def initialize(table)
    @table = table
  end

  def channel_names
    %w[lobby]
  end

  def data
    TableSerializer.new(@table, except: :board).as_json
  end
end
