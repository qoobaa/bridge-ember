class Event::CardCreated < Event
  def initialize(table, card)
    @table = table
    @card = card
  end

  def channel_names
    %W[table_#{@table.id}]
  end

  def data
    CardSerializer.new(@card).as_json
  end
end
