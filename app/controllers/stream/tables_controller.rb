class Stream::TablesController < Stream::ApplicationController
  def index
    sse.write(ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board), event: "tables")

    ActiveRecord::Base.clear_active_connections!

    redis_subscribe("tables") do |on|
      on.message do |channel, payload|
        message = JSON.parse(payload)
        sse.write(message["data"], event: message["event"])
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
