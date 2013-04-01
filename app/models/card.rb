class Card < ActiveRecord::Base
  belongs_to :board_id

  validates :board_id, presence: true
  validates :content,  presence: true, uniqueness: {scope: :board_id}
end
