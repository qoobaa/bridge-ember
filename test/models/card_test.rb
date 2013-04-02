require "test_helper"

class CardTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:card).valid?
  end

  test "is invalid with not existing card" do
    assert build(:card, content: "SU").invalid?
  end

  test "is invalid with card that does not belong to current hand" do
    board = create(:board, deal_id: "0", contract: "7SN")
    create(:card, board: board, content: "HA")
    assert build(:card, board: board.reload, content: "C2").invalid?
  end

  test "returns Bridge::Card object on card" do
    assert_equal Bridge::Card, build(:card, content: "HA").card.class
  end

  test "returns nil when card invalid" do
    assert_nil build(:card, content: "ZA").card
  end
end
