require "test_helper"

class Api::TablesControllerTest < ActionController::TestCase
  # show
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
          "id" => board.id,
          "dealer" => "N",
          "vulnerable" => "NONE",
          "bids" => ["7S", "PASS", "PASS", "PASS"],
          "cards" => ["HA"],
          "result" => nil,
          "claim" => nil
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

  # join
  test "joins table to given direction" do
    user = create(:user)
    table = create(:table)
    sign_in(user)

    patch :join, id: table.id, table: {direction: "N"}, format: :json

    assert_response :no_content

    assert_equal user, table.reload.user_n
  end

  test "does not allow to join more than once to the same table" do
    user = create(:user)
    table = create(:table, user_n: user)
    sign_in(user)

    patch :join, id: table.id, table: {direction: "E"}, format: :json

    assert_response :unauthorized

    assert_nil table.reload.user_e
  end

  test "does not allow to join to occupied direction" do
    user_1 = create(:user)
    user_2 = create(:user)
    table = create(:table, user_n: user_1)
    sign_in(user_2)

    patch :join, id: table.id, table: {direction: "N"}, format: :json

    assert_response :unauthorized

    assert_equal user_1, table.reload.user_n
  end

  test "returns bad request when invalid direction given" do
    user = create(:user)
    table = create(:table)
    sign_in(user)

    patch :join, id: table.id, table: {direction: "X"}, format: :json

    assert_response :bad_request
  end

  test "creates board when fourth user joining" do
    table = create(:table, user_n: create(:user), user_e: create(:user), user_s: create(:user))
    user = create(:user)
    sign_in(user)

    patch :join, id: table.id, table: {direction: "W"}, format: :json

    refute_nil table.reload.board
  end

  # quit
  test "removes current user from table" do
    user = create(:user)
    table = create(:table, user_n: user)
    sign_in(user)

    patch :quit, id: table.id, table: {direction: "N"}, format: :json

    assert_response :no_content

    assert_nil table.reload.user_n
  end

  test "returns unauthorized when user is not sitting at given direction" do
    user = create(:user)
    table = create(:table, user_n: user)
    sign_in(user)

    patch :quit, id: table.id, table: {direction: "E"}, format: :json

    assert_response :unauthorized
  end
end
