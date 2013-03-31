class Api::SessionsController < Api::ApplicationController
  def create

  end

  def destroy
    session.delete(:user_id)
  end
end
