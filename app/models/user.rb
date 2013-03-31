class User < ActiveRecord::Base
  has_many :channels

  validates :email, presence: true, uniqueness: {case_sensitive: false}
end
