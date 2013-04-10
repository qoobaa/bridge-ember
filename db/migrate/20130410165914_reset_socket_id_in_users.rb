class ResetSocketIdInUsers < ActiveRecord::Migration
  class User < ActiveRecord::Base; end

  def change
    User.find_each { |user| user.update_attributes!(socket_id: SecureRandom.hex) }
  end
end
