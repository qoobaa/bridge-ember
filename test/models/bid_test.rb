require "test_helper"

class BidTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:bid).valid?
  end

  test "is invalid with bid not existing bid" do
    assert build(:bid, content: "8S").invalid?
  end

  test "is invalid with bid lower then previous one in board" do
    board = create(:board)
    create(:bid, board: board, content: "1NT")
    assert build(:bid, board: board.reload, content: "1S").invalid?
  end

  test "returns Bridge::Bid object on bid" do
    assert_equal Bridge::Bid, build(:bid, content: "1NT").bid.class
  end

  test "returns nil when bid invalid" do
    assert_nil build(:bid, content: "8NT").bid
  end
end
