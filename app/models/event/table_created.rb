class Event::TableCreated < Event
  channel :lobby

  def initialize(table)
    @table = table
  end

  def data
    TableSerializer.new(@table, except: :board).as_json
  end
end
