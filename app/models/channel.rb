class Channel < ActiveRecord::Base
  belongs_to :user
  validates :name, presence: true, uniqueness: true

  def self.active
    where(arel_table[:connected_at].not_eq(nil)).where(disconnected_at: nil).where(arel_table[:user_id].not_eq(nil))
  end

  def connect!
    update_attributes!(connected_at: DateTime.now, disconnected_at: nil)
  end

  def disconnect!
    update_attributes!(disconnected_at: DateTime.now)
  end

  def publish(message)
    message = message.to_json unless message.is_a?(String)
    listeners = redis.publish(name, message)
    disconnect! if listeners.zero?
  end
end