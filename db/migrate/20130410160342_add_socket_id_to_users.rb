class AddSocketIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :socket_id, :string
  end
end
