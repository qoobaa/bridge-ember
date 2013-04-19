require "test_helper"

class ClaimTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:claim).valid?
  end

  test "is invalid when direction is dummy" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "N").invalid?
  end

  test "is invalid when too much tricks" do
    board = create(:board, contract: "1NTN")
    board.cards.create!(content: "HA")
    board.cards.create!(content: "D2")
    board.cards.create!(content: "C2")
    board.cards.create!(content: "S2")

    assert build(:claim, board: board, direction: "N", tricks: 13).invalid?
  end

  test "is accepted when lho and rho accepted" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "S", accepted: ["E", "W"]).accepted?
  end

  test "is not accepted when only one opponent accepted" do
    board = create(:board, contract: "1NTS")

    refute build(:claim, board: board, direction: "S", accepted: ["W"]).accepted?
  end

  test "is accepted when declarer accepted" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "E", accepted: ["S"]).accepted?
  end

  test "is rejected when someone rejected" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "S", rejected: ["E"]).rejected?
  end

  test "accepts claim" do
    board = create(:board, contract: "1NTS")
    claim = create(:claim, direction: "S")

    assert claim.accept("E")
    assert_equal ["E"], claim.reload.accepted
  end

  test "rejects claim" do
    board = create(:board, contract: "1NTS")
    claim = create(:claim, direction: "S")

    assert claim.reject("E")
    assert_equal ["E"], claim.reload.rejected
  end

  test "returns declarer tricks number when opponent claimed" do
    board = create(:board, contract: "1NTN")
    board.cards.create!(content: "HA")
    board.cards.create!(content: "D2")
    board.cards.create!(content: "C2")
    board.cards.create!(content: "S2")
    board.cards.create!(content: "HK")

    claim = build(:claim, board: board, direction: "E", tricks: 5)
    assert_equal 7, claim.declarer_tricks_number
  end
end
