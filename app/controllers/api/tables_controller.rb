class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create, :join, :quit]

  def index
    @tables = Table.order(:created_at)
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

    user_key = :"user_#{direction.downcase}"
    if @table.user_direction(current_user).nil? && @table.send(user_key).nil?
      @table.update!(user_key => current_user)
      if @table.users.count == 4
        @table.create_board!
        # TODO: notify players about board with proper scope
        # currently all are getting last joined player cards
        redis_publish(event: "tables/#{@table.id}/update", data: TableSerializer.new(@table, scope: current_user))
      else
        redis_publish(event: "tables/#{@table.id}/update", data: TableShortSerializer.new(@table))
      end

      head :ok
    else
      head :unauthorized
    end
  end

  def quit
    @table = Table.find(params[:id])
    if direction = @table.user_direction(current_user)
      user_key = :"user_#{direction.downcase}"
      @table.update!(user_key => nil)
      redis_publish(event: "tables/#{@table.id}/update", data: TableShortSerializer.new(@table))
      head :ok
    else
      head :unauthorized
    end
  end
end
