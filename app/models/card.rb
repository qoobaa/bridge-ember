class Card < ActiveRecord::Base
  belongs_to :board

  validates :board_id, presence: true
  validates :content,  presence: true, inclusion: {in: Bridge::DECK, message: :invalid}, uniqueness: {scope: :board_id}
end
