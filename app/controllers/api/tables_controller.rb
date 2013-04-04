class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create]

  def index
    @tables = Table.all
    render json: @tables, root: false
  end

  def show
    @table = Table.find(params[:id])
    render json: @table, root: false
  end

  def create
    @table = Table.create!
    redis_publish(event: "tables/create", data: TableSerializer.new(@table, root: false))
    render json: @table, root: false
  end
end
