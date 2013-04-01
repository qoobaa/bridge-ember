class Api::BoardsController < Api::ApplicationController
  def show
    @board = Board.find(params[:id])
  end
end
