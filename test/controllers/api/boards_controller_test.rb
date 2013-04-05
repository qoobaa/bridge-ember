require "test_helper"

class Api::BoardsControllerTest < ActionController::TestCase
  test "returns board JSON" do
    board = create(:board, dealer: "N", vulnerable: "NONE", deal_id: "0", contract: "7SN")
    create(:bid, board: board, content: "7S")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:card, board: board, content: "HA")

    get :show, id: board.id, format: :json

    expected = {
      "board" => {
        "dealer" => "N",
        "vulnerable" => "NONE",
        "bids" => ["7S", "PASS", "PASS", "PASS"],
        "cards" => ["HA"]
      }
    }
    assert_equal expected, json_response
  end
end
