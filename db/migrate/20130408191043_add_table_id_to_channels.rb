class AddTableIdToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :table_id, :integer
  end
end
