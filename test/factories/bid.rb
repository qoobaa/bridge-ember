FactoryGirl.define do
  factory :bid do
    sequence(:board_id)
    sequence(:content) { |i| Bridge::BIDS[i] }
  end
end
