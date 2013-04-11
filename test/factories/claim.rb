FactoryGirl.define do
  factory :claim do
    sequence(:board_id)
    direction "N"
    tricks 5
  end
end
