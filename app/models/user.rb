class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates :socket_id, presence: true

  before_validation :generate_socket_id

  def publish(message)
    redis_publish(message.merge(channel: socket_id))
  end

  def online?
    publish(event: "ping") == 1
  end

  def reset_socket_id!
    update_attributes!(socket_id: SecureRandom.hex)
  end

  private

  def generate_socket_id
    self.socket_id = SecureRandom.hex
  end
end
