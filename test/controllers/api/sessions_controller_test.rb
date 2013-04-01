require "test_helper"

class Api::SessionsControllerTest < ActionController::TestCase
  test "sets user_id in session" do
    post :create, session: {email: "homer@simpson.com"}, format: :json

    assert_not_nil session[:user_id]
  end

  test "removes user_id from session" do
    session[:user_id] = create(:user).id
    delete :destroy, format: :json

    assert_nil session[:user_id]
  end
end
