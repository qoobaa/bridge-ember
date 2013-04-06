class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create, :join, :quit]

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

  def join
    @table = Table.find(params[:id])
    direction = params.require(:table).require(:direction)
    head(:bad_request) && return unless Bridge.direction?(direction)

    if @table.user_direction(current_user).nil? && @table.send(:"user_#{direction.downcase}").nil?
      @table.update!("user_#{direction.downcase}" => current_user)
      redis_publish(event: "tables/#{@table.id}/join", data: TableShortSerializer.new(@table))
      head :ok
    else
      head :unauthorized
    end
  end

  def quit
    @table = Table.find(params[:id])
    if direction = @table.user_direction(current_user)
      @table.update!("user_#{direction.downcase}" => nil)
      # redis_publish(event: "tables/create", data: TableSerializer.new(@table))
      head :ok
    else
      head :unauthorized
    end
  end
end
