require "test_helper"

class Api::ClaimsControllerTest < ActionController::TestCase
  setup do
    @user = create(:user)
    sign_in(@user)
  end

  # create
  test "creates claim" do
    board = create(:board, table: create(:table), contract: "1NTN", user_e: @user)

    post :create, board_id: board.id, claim: {direction: "E", tricks: 6}, format: :json

    assert_response :created
  end

  test "does not allow to claim for other direction" do
    board = create(:board, table: create(:table), contract: "1NTN", user_e: @user)

    post :create, board_id: board.id, claim: {direction: "N", tricks: 0}, format: :json

    assert_response :unauthorized
  end

  test "does not allow to claim when other claim still active" do
    board = create(:board, table: create(:table), contract: "1NTN", user_e: @user)
    create(:claim, board: board, direction: "N", tricks: 10)

    post :create, board_id: board.id, claim: {direction: "E", tricks: 6}, format: :json

    assert_response :unauthorized
  end

  # accept
  test "accepts claim by given direction" do
    board = create(:board, table: create(:table), contract: "1NTN", user_e: @user)
    claim = create(:claim, board: board, direction: "N", tricks: 10)

    patch :accept, board_id: board.id, id: claim.id, claim: {accepted: "E"}, format: :json

    assert_response :no_content
  end

  test "does not allow to accept when claim resolved" do
    board = create(:board, table: create(:table), contract: "1NTN", user_e: @user)
    claim = create(:claim, board: board, direction: "N", tricks: 10, rejected: ["W"])

    patch :accept, board_id: board.id, id: claim.id, claim: {accepted: "E"}, format: :json

    assert_response :unauthorized
  end
end
