require "sse"

class Stream::ApplicationController < ActionController::Base
  include ActionController::Live
  include CurrentUser

  before_action :set_headers, :current_user

  private

  def set_headers
    response.headers["Content-Type"] = "text/event-stream"
    response.headers["Access-Control-Allow-Origin"] = "*"
  end

  def sse
    return @sse if defined?(@sse)
    @sse = SSE.new(response.stream)
  end
end
