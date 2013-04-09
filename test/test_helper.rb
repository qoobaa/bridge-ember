ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  include FactoryGirl::Syntax::Methods

  teardown do
    Redis.current.flushdb
  end

  def json_response
    ActiveSupport::JSON.decode(response.body)
  end
end

class ActionController::TestCase
  def sign_in(user)
    session[:user_id] = user.id
  end
end
