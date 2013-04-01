FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "homer_#{i}@simpson.com" }
  end
end
