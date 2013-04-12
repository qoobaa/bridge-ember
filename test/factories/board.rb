FactoryGirl.define do
  sequence :user_id_sequence, 1000

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

# deail_id: 0
# "N"=>["SA", "SK", "SQ", "SJ", "ST", "S9", "S8", "S7", "S6", "S5", "S4", "S3", "S2"]
# "E"=>["HA", "HK", "HQ", "HJ", "HT", "H9", "H8", "H7", "H6", "H5", "H4", "H3", "H2"]
# "S"=>["DA", "DK", "DQ", "DJ", "DT", "D9", "D8", "D7", "D6", "D5", "D4", "D3", "D2"]
# "W"=>["CA", "CK", "CQ", "CJ", "CT", "C9", "C8", "C7", "C6", "C5", "C4", "C3", "C2"]
