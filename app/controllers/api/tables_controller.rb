class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: %w[create join quit]
  before_action :check_direction, only: %w[join quit]
  before_action :authorize_join, only: %w[join]
  before_action :authorize_quit, only: %w[quit]

  def create
    @table = Table.create!
    redis_publish("tables", event: "tables/create", data: TableSerializer.new(table, except: :board))
    respond_with(table, location: nil)
  end

  def join
    table.update!(user_key => current_user)
    redis_publish("service", event: "disconnect", table_id: table.id, user_id: current_user.id)
    redis_publish("tables", event: "tables/create", data: TableSerializer.new(table, except: :board))
    if table.users.count == 4
      table.create_board!

      table.users.each do |user|
        redis_publish "tables/#{table.id}/#{table.user_direction(user).downcase}", event: "table/update", data: TableSerializer.new(table, scope: user, scope_name: :current_user)
      end
      redis_publish "tables/#{table.id}/guest", event: "table/update", data: TableSerializer.new(table)
    else
      redis_publish("tables/#{table.id}", event: "table/update", data: TableSerializer.new(table, except: :board))
    end
    respond_with(table)
  end

  def quit
    table.update!(user_key => nil)
    redis_publish("service", event: "disconnect", table_id: table.id, user_id: current_user.id)
    redis_publish("tables", event: "tables/update", data: TableSerializer.new(table, except: :board))
    redis_publish("tables/#{table.id}", event: "table/update", data: TableSerializer.new(table, except: :board))
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
