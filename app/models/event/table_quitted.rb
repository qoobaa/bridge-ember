class Event::TableQuitted < Event
  def initialize(table, user)
    @table = table
    @user = user
  end

  def channel_names
    %W[lobby table_#{@table.id}]
  end

  def data
    TableSerializer.new(@table, except: :board).as_json
  end

  def disconnect?
    @user.id == current_user.try(:id)
  end
end
