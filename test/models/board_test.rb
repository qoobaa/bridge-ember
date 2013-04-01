require "test_helper"

class BoardTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:board).valid?
  end
end
