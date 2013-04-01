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

    post :create, board_id: board.id, bid: {content: "8NT"}, format: :json

    expected = {"errors" => {"content"=> ["is not included in the list"]}}

    assert_response :unprocessable_entity
    assert_equal(expected, json_response)
  end
end
