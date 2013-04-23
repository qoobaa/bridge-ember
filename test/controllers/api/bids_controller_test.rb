require "test_helper"

class Api::BidsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in(@user)
  end

  test "creates bid" do
    board = create(:board, table: create(:table), dealer: "N", user_n: @user, table: create(:table))

    post :create, board_id: board.id, bid: {content: "2H"}, format: :json

    assert_response :created
    assert_equal({"bid" => {"content" => "2H"}}, json_response)
  end

  test "creates alerted bid" do
    board = create(:board, table: create(:table), dealer: "N", user_n: @user, table: create(:table))

    post :create, board_id: board.id, bid: {content: "2D", alert: "wilkosz"}, format: :json

    assert_response :created
    assert_equal({"bid" => {"content" => "2D!wilkosz"}}, json_response)
  end

  test "returns validation error" do
    board = create(:board, table: create(:table), dealer: "N", user_e: @user, table: create(:table))
    create(:bid, board: board, content: "1NT")

    post :create, board_id: board.id, bid: {content: "1S"}, format: :json

    expected = {"errors" => {"content"=> ["is not allowed"]}}

    assert_response :unprocessable_entity
    assert_equal(expected, json_response)
  end

  test "sets contract on board when auction finished" do
    board = create(:board, table: create(:table), dealer: "N", user_w: @user, table: create(:table))
    create(:bid, board: board, content: "1NT")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")

    post :create, board_id: board.id, bid: {content: "PASS"}, format: :json

    assert_response :created
    assert_equal "1NTN", board.reload.contract
  end

  test "returns unathorized when user is not current direction" do
    board = create(:board, table: create(:table), dealer: "N", user_e: @user, table: create(:table))

    post :create, board_id: board.id, bid: {content: "2H"}, format: :json

    assert_response :unauthorized
  end
end
