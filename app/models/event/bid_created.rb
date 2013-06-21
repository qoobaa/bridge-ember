class Event::BidCreated < Event
  def initialize(table, bid)
    @table = table
    @bid = bid
    board = bid.board # eager load association
  end

  def channel_names
    %W[table_#{@table.id}]
  end

  def data
    BidSerializer.new(@bid, scope: current_user, scope_name: :current_user).as_json
  end
end
