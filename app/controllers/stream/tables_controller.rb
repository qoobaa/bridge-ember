require "sse"

class Stream::TablesController < Stream::ApplicationController
  before_action :current_user # prefetch current_user

  def index
    response.headers["Content-Type"] = "text/event-stream"
    sse = SSE.new(response.stream)
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
