class Api::ApplicationController < ActionController::Base
  include CurrentUser

  protect_from_forgery with: :null_session
  respond_to :json

  def require_user
    head :unauthorized if logged_out?
  end

  def require_no_user
    head :unauthorized if logged_in?
  end
end
