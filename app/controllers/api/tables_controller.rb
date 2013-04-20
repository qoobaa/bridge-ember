class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create, :join, :quit]
  before_action :check_direction, only: [:join, :quit]
  before_action :authorize_join, only: [:join]
  before_action :authorize_quit, only: [:quit]

  def index
    @tables = Table.order(:created_at)
    respond_with(@tables, each_serializer: TableShortSerializer)
  end

  def show
    respond_with(table)
  end

  def create
    @table = Table.create!
    redis_publish(event: "tables/create", data: TableShortSerializer.new(@table))
    respond_with(table)
  end

  def join
    table.update!(user_key => current_user)
    if table.users.count == 4
      table.create_board!

      table.users.each do |user|
        user.publish event: "table/update", data: TableSerializer.new(table, scope: user, scope_name: :current_user)
      end
    else
      table.publish(event: "table/update", data: TableShortSerializer.new(table))
    end
    respond_with(table)
  end

  def quit
    table.update!(user_key => nil)
    table.publish(event: "table/update", data: TableShortSerializer.new(table))
    respond_with(table)
  end

  private

  def table
    @table ||= Table.find(params[:id])
  end

  def user_key
    "user_#{params[:table][:direction].downcase}".to_sym
  end

  def check_direction
    head(:bad_request) unless Bridge.direction?(params.require(:table)[:direction])
  end

  def authorize_join
    head(:unauthorized) unless TableAuthorizer.new(current_user).join_allowed?(table, user_key)
  end

  def authorize_quit
    head(:unauthorized) unless TableAuthorizer.new(current_user).quit_allowed?(table, user_key)
  end
end
