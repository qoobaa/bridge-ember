require "test_helper"

class BidTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:bid).valid?
  end

  test "is invalid with bid not existing bid" do
    assert build(:bid, content: "8S").invalid?
  end
end
