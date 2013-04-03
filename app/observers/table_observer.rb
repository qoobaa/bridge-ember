class TableObserver < ActiveRecord::Observer
  observe :table

  def after_create(table)
    redis_publish(event: "tables/create", data: table.to_json)
  end

  def after_update(table)
    redis_publish(event: "tables/update", data: table.to_json)
  end

  def after_destroy(table)
    redis_publish(event: "tables/destroy", data: table.to_json)
  end
end
