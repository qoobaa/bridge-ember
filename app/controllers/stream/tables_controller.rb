class Stream::TablesController < Stream::ApplicationController
  def index
    sse.write(event: "tables", data: ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board))

    ActiveRecord::Base.clear_active_connections!

    redis_subscribe("tables") do |on|
      on.message do |channel, payload|
        sse.write(payload)
      end
    end
  rescue IOError
  ensure
    sse.close
  end

  def show
  rescue IOError
  ensure
    sse.close
  end

  private

  def table
    @table ||= Table.find(params[:id])
  end
end
