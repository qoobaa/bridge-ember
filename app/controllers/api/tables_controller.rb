class Api::TablesController < Api::ApplicationController
  def index
    @tables = Table.all
  end

  def show
    @table = Table.find(params[:id])
  end

  def create
    @table = Table.create!
  end
end
