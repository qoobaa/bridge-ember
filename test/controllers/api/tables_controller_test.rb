require "test_helper"

class Api::TablesControllerTest < ActionController::TestCase
  test "returns table JSON without visible hands when no user signed in" do
    table = create(:table)
    board = create(:board, table: table, dealer: "N", vulnerable: "NONE", deal_id: "0", contract: "7SN")
    create(:bid, board: board, content: "7S")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:card, board: board, content: "HA")

    get :show, id: table.id, format: :json

    expected = {
      "table" => {
        "id" => table.id,
        "user_n" => nil,
        "user_e" => nil,
        "user_s" => nil,
        "user_w" => nil,
        "board" => {
          "dealer" => "N",
          "vulnerable" => "NONE",
          "bids" => ["7S", "PASS", "PASS", "PASS"],
          "cards" => ["HA"]
        }
      }
    }
    assert_equal expected, json_response
  end

  test "returns table JSON with signed in user hand" do
    user = create(:user)
    table = create(:table, user_w: user)
    board = create(:board, table: table, user_w: user, deal_id: "0")
    sign_in(user)

    get :show, id: table.id, format: :json

    assert_nil json_response["table"]["board"]["n"]
    assert_nil json_response["table"]["board"]["e"]
    assert_nil json_response["table"]["board"]["s"]
    assert_equal board.deal["W"], json_response["table"]["board"]["w"]
  end

  test "returns table JSON with signed in user hand and dummy when first card played" do
    user = create(:user)
    table = create(:table, user_n: user)
    board = create(:board, table: table, user_n: user, deal_id: "0", contract: "7SN")
    create(:bid, board: board, content: "7S")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")
    create(:card, board: board, content: "HA")

    sign_in(user)

    get :show, id: table.id, format: :json

    assert_equal board.deal["N"], json_response["table"]["board"]["n"]
    assert_nil json_response["table"]["board"]["e"]
    assert_equal board.deal["S"], json_response["table"]["board"]["s"]
    assert_nil json_response["table"]["board"]["w"]
  end
end
