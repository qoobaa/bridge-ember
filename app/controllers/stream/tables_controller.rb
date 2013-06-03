class Stream::TablesController < Stream::ApplicationController
  def index
    response.headers["Content-Type"] = "text/event-stream"

    tables = ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board)

    ActiveRecord::Base.clear_active_connections!

    redis_subscribe("tables") do |on|
      on.message do |channel, payload|
        message = JSON.parse(payload)
        response.stream.write "event: #{message['event']}\n"
        response.stream.write "data: #{message['data'].to_json}\n\n"
      end
    end
  rescue IOError
  ensure
    response.close
  end

  def show
    response.headers["Content-Type"] = "text/event-stream"
  rescue IOError
  ensure
    response.close
  end

  private

  def table
    @table ||= Table.find(params[:id])
  end
end
