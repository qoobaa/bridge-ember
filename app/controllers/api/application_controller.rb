class Api::ApplicationController < ActionController::Base
  include CurrentUser

  protect_from_forgery with: :null_session
  respond_to :json
end
