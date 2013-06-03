require "sse"

class Stream::ApplicationController < ActionController::Base
  include ActionController::Live
  include CurrentUser

  before_action :set_content_type, :current_user

  private

  def set_content_type
    response.headers["Content-Type"] = "text/event-stream"
  end

  def sse
    return @sse if defined?(@sse)
    @sse = SSE.new(response.stream)
  end
end
