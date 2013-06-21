class Stream::TablesController < Stream::ApplicationController
  def index
    sse.write(event: "init", data: ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board))

    ActiveRecord::Base.clear_active_connections!

    Event.subscribe("lobby") do |event|
      response.stream.write("\n")
      sse.write(event.as_json) if event.present?
    end
  rescue IOError
  ensure
    sse.close
  end

  def show
    sse.write(event: "init", data: TableSerializer.new(table, scope: current_user, scope_name: :current_user))

    ActiveRecord::Base.clear_active_connections!

    Event.subscribe("table_#{table.id}") do |event|
      if event.present?
        event.current_user = current_user
        response.stream.close if event.disconnect?
        sse.write(event.as_json)
      end
      response.stream.write("\n")
    end
  rescue IOError
  ensure
    sse.close
  end

  private

  def table
    @table ||= Table.find(params[:id])
  end
end
