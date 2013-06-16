class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: [:create, :join, :quit]
  before_action :check_direction, only: [:join, :quit]
  before_action :authorize_join, only: [:join]
  before_action :authorize_quit, only: [:quit]

  def index
    @tables = Table.order(:created_at)
    respond_with(@tables, except: :board)
  end

  def show
    respond_with(table)
  end

  def create
    @table = Table.create!
    # publish table create to lobby (data: table_id)
    respond_with(table, location: nil)
  end

  def join
    table.update!(user_key => current_user)
    # publish table join to lobby (data: table_id, name, direction)
    # publish table join to table (data: table_id, name, direction)
    if table.users.count == 4
      table.create_board!
      # publish board update to table (data: board)
    end
    respond_with(table)
  end

  def quit
    table.update!(user_key => nil)
    # publish table quit to lobby (data: table_id, direction)
    # publish table quit to table (data: table_id, direction)
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
