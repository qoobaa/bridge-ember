class DropChannels < ActiveRecord::Migration
  def up
    drop_table :channels
  end

  def down
    create_table :channels do |t|
      t.integer :user_id
      t.integer :table_id
      t.string :name
      t.datetime :connected_at
      t.datetime :disconnected_at

      t.timestamps
    end
  end
end
