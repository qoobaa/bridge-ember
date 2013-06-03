class Stream::TablesController < Stream::ApplicationController
  def index
    response.headers["Content-Type"] = "text/event-stream"
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
