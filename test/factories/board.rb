FactoryGirl.define do
  factory :board do
    sequence(:user_n_id)
    sequence(:user_e_id)
    sequence(:user_s_id)
    sequence(:user_w_id)
    deal_id "12345"
    dealer "N"
    vulnerable "BOTH"
  end
end
