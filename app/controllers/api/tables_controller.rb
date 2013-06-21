class Api::TablesController < Api::ApplicationController
  before_action :require_user, only: %w[create join quit]
  before_action :check_direction, only: %w[join quit]
  before_action :authorize_join, only: %w[join]
  before_action :authorize_quit, only: %w[quit]

  def create
    @table = Table.create!
    Event::TableCreated.new(@table)
    respond_with(table, location: nil)
  end

  def join
    table.update!(user_key => current_user)
    Event::Join.new(table)
    if table.users.count == 4
      table.create_board!
      Event::BoardCreated.new(table)
    end
    respond_with(table)
  end

  def quit
    table.update!(user_key => nil)
    Event::Quit.new(table)
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
