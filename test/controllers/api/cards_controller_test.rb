require "test_helper"

class Api::CardsControllerTest < ActionController::TestCase
  test "creates card" do
    board = create(:board)

    post :create, board_id: board.id, card: {content: "HA"}, format: :json

    assert_response :created
    assert_equal({"card" => "HA"}, json_response)
  end

  test "returns validation error" do
    board = create(:board)

    post :create, board_id: board.id, card: {content: "WA"}, format: :json

    expected = {"errors" => {"content"=> ["is not included in the list"]}}

    assert_response :unprocessable_entity
    assert_equal(expected, json_response)
  end
end
