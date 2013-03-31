class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.integer :user_id
      t.string :name
      t.datetime :connected_at
      t.datetime :disconnected_at

      t.timestamps
    end
  end
end
