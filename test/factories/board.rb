FactoryGirl.define do
  sequence :user_id_sequence

  factory :board do
    user_n_id { generate(:user_id_sequence) }
    user_e_id { generate(:user_id_sequence) }
    user_s_id { generate(:user_id_sequence) }
    user_w_id { generate(:user_id_sequence) }
    deal_id "0"
    dealer "N"
    vulnerable "BOTH"
  end
end
