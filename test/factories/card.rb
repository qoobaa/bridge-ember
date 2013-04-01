FactoryGirl.define do
  factory :card do
    sequence(:board_id)
    sequence(:content) { |i| Bridge::DECK[i] }
  end
end
