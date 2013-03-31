class Api::ApplicationController < ActionController::Base
  def logged_in?
    current_user.present?
  end

  def logged_out?
    current_user.blank?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end
end
