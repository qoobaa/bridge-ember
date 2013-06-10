class Stream::TablesController < Stream::ApplicationController
  def index
    sse.write(event: "tables", data: ActiveModel::ArraySerializer.new(Table.all, each_serializer: TableSerializer, except: :board))

    ActiveRecord::Base.clear_active_connections!

    redis_subscribe("tables") do |on|
      on.message { |channel, payload| sse.write(payload) }
    end
  rescue IOError
  ensure
    sse.close
  end

  def show
    channel_names = [
      "tables/#{table.id}",
      "tables/#{table.id}/#{table.user_direction(current_user).try(:downcase) or 'guest'}"
    ]

    sse.write(event: "table", data: TableSerializer.new(table, scope: current_user, scope_name: :current_user))

    ActiveRecord::Base.clear_active_connections!

    redis_subscribe(*channel_names) do |on|
      on.message do |channel, payload|
        if channel.ends_with?("service")
          data = JSON.parse(payload)
          if data["event"] == "disconnect" and table.id = data["table_id"] and data["user_id"] == current_user.id
            raise IOError
          else
            sse.write(payload)
          end
        else
          sse.write(payload)
        end
      end
    end
  rescue IOError
  ensure
    redis.quit
    sse.close
  end

  private

  def table
    @table ||= Table.find(params[:id])
  end
end
