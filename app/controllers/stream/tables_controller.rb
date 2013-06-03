class Stream::TablesController < Stream::ApplicationController
  def index
    response.headers["Content-Type"] = "text/event-stream"

    tables = ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board)

    response.stream.write "event: tables\n"
    response.stream.write "data: #{tables.to_json}\n\n"
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
