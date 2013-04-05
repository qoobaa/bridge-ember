class AddTableIdToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :table_id, :integer
  end
end
