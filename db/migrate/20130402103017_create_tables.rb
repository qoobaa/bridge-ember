class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :user_n_id
      t.integer :user_e_id
      t.integer :user_s_id
      t.integer :user_w_id

      t.timestamps
    end
  end
end
