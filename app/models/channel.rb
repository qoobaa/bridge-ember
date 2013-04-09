class Channel < ActiveRecord::Base
  belongs_to :user
  belongs_to :table
  validates :name, presence: true, uniqueness: true

  def self.active
    where.not(connected_at: nil).where(disconnected_at: nil).where.not(user_id: nil)
  end

  def connect!
    update!(connected_at: DateTime.now, disconnected_at: nil)
  end

  def disconnect!
    update!(disconnected_at: DateTime.now)
  end

  def publish(message)
    listeners = redis_publish(message.merge(channel: name))
    disconnect! if listeners.zero?
  end
end
