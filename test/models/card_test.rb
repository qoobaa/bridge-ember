require "test_helper"

class CardTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:card).valid?
  end

  test "is invalid with not existing card" do
    assert build(:card, content: "SU").invalid?
  end
end
