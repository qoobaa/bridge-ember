require "test_helper"

class Api::BidsControllerTest < ActionController::TestCase
  test "creates bid" do
    board = create(:board)

    post :create, board_id: board.id, bid: {content: "2H"}, format: :json

    assert_response :created
    assert_equal({"bid" => "2H"}, json_response)
  end

  test "returns validation error" do
    board = create(:board)
    create(:bid, board: board, content: "1NT")

    post :create, board_id: board.id, bid: {content: "1S"}, format: :json

    expected = {"errors" => {"content"=> ["is not allowed"]}}

    assert_response :unprocessable_entity
    assert_equal(expected, json_response)
  end

  test "sets contract on board when auction finished" do
    board = create(:board, dealer: "N")
    create(:bid, board: board, content: "1NT")
    create(:bid, board: board, content: "PASS")
    create(:bid, board: board, content: "PASS")

    post :create, board_id: board.id, bid: {content: "PASS"}, format: :json

    assert_response :created
    assert_equal "1NTN", board.reload.contract
  end
end
