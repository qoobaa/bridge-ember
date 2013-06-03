class RemoveSocketIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :socket_id, :string
  end
end
