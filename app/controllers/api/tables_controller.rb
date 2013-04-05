class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create]

  def index
    @tables = Table.all
    render json: @tables, each_serializer: TableShortSerializer
  end

  def show
    @table = Table.find(params[:id])
    render json: @table
  end

  def create
    @table = Table.create!
    redis_publish(event: "tables/create", data: TableSerializer.new(@table))
    render json: @table
  end
end
