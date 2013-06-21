class Event::BoardUpdated < Event
  def initialize(table)
    @table = table
    table.board # eager load association
  end

  def channel_names
    %W[table_#{@table.id}]
  end

  def data
    BoardSerializer.new(@table.board, scope: current_user, scope_name: :current_user).as_json
  end
end
