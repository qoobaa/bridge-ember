class TableAuthorizer
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def join_allowed?(table, user_key)
    table.send(user_key).nil? and table.user_direction(user).nil?
  end

  def quit_allowed?(table, user_key)
    table.send(user_key) == user
  end
end
