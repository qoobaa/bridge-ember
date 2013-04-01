class Card < ActiveRecord::Base
  belongs_to :board

  validates :board_id, presence: true
  validates :content,  presence: true, inclusion: Bridge::DECK, uniqueness: {scope: :board_id}
end
