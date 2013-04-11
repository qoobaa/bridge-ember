require "test_helper"

class ClaimTest < ActiveSupport::TestCase
  test "is valid" do
    assert build(:claim).valid?
  end

  test "is invalid when direction is dummy" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "N").invalid?
  end

  test "is accepted when lho and rho accepted" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "S", accepted_directions: ["E", "W"]).accepted?
  end

  test "is not accepted when only one opponent accepted" do
    board = create(:board, contract: "1NTS")

    refute build(:claim, board: board, direction: "S", accepted_directions: ["W"]).accepted?
  end

  test "is accepted when declarer accepted" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "E", accepted_directions: ["S"]).accepted?
  end

  test "is rejected when someone rejected" do
    board = create(:board, contract: "1NTS")

    assert build(:claim, board: board, direction: "S", rejected_directions: ["E"]).rejected?
  end
end
