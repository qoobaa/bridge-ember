require "test_helper"

class BoardTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:board).valid?
  end

  test "hands are visible only to owners without first lead" do
    board = build(:board)

    assert board.visible_hand_for?("N", "N")
    refute board.visible_hand_for?("N", "E")
    refute board.visible_hand_for?("N", "S")
    refute board.visible_hand_for?("N", "W")
  end

  test "dummy hand is visible to all after first lead" do
    board = create(:board, deal_id: "0", contract: "7SN")
    create(:card, board: board, content: "HA")

    assert board.visible_hand_for?("S", "N")
    assert board.visible_hand_for?("S", "E")
    assert board.visible_hand_for?("S", "S")
    assert board.visible_hand_for?("S", "W")
  end

  test "dummy can see all hands after first lead" do
    board = create(:board, deal_id: "0", contract: "7SN")
    create(:card, board: board, content: "HA")

    assert board.visible_hand_for?("N", "S")
    assert board.visible_hand_for?("E", "S")
    assert board.visible_hand_for?("S", "S")
    assert board.visible_hand_for?("W", "S")
  end
end
