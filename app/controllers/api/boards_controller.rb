class Api::BoardsController < Api::ApplicationController
  def show
    @board = Board.find(params[:id])

    respond_with(@board)
  end
end
