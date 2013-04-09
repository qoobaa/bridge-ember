require "test_helper"

class Api::CardsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in(@user)
  end

  test "creates card" do
    board = create(:board, deal_id: "0", contract: "7SN", user_e: @user, table: create(:table))

    post :create, board_id: board.id, card: {content: "HA"}, format: :json

    assert_response :created
    assert_equal({"card" => {"content" => "HA"}}, json_response)
  end

  test "returns validation error" do
    board = create(:board, deal_id: "0", contract: "7SN", user_e: @user, table: create(:table))

    post :create, board_id: board.id, card: {content: "DA"}, format: :json

    expected = {"errors" => {"content" => ["is not allowed"]}}

    assert_response :unprocessable_entity
    assert_equal(expected, json_response)
  end

  test "returns unathorized when user is not current direction" do
    board = create(:board, deal_id: "0", contract: "7SN", user_n: @user, table: create(:table))

    post :create, board_id: board.id, card: {content: "HA"}, format: :json

    assert_response :unauthorized
  end

  test "authorizes declarer to play dummy's card" do
    board = create(:board, deal_id: "0", contract: "7SN", user_n: @user, table: create(:table))
    create(:card, board: board, content: "HA")

    post :create, board_id: board.id, card: {content: "D2"}, format: :json

    assert_response :created
    assert_equal({"card" => {"content" => "D2"}}, json_response)
  end
end
