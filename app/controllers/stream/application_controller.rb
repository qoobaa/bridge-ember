class Stream::ApplicationController < ActionController::Base
  include ActionController::Live
  include CurrentUser
end
