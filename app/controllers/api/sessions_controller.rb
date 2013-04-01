class Api::SessionsController < Api::ApplicationController
  before_filter :require_no_user, only: :create
  before_filter :require_user, only: :destroy

  def create
    @user = User.find_or_create_by!(session_params)
    session[:user_id] = @user.id

    render status: :created
  end

  def destroy
    session.delete(:user_id)

    head :ok
  end

  private

  def session_params
    params.require(:session).permit(:email)
  end
end
