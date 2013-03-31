class Api::ApplicationController < ActionController::Base
  include CurrentUser

  respond_to :json
end
