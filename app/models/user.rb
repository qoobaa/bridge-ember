class User < ActiveRecord::Base
  has_many :channels

  validates :email, presence: true, uniqueness: {case_sensitive: false}
  before_validation :generate_socket_id

  def publish(message)
    redis_publish(message.merge(channel: socket_id))
  end

  def online?
    not publish(event: "ping").zero?
  end

  private

  def generate_socket_id
    self.socket_id = SecureRandom.hex
  end
end
