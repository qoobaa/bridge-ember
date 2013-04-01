class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :deal_id, null: false
      t.string :dealer, null: false
      t.string :vulnerable, null: false
      t.string :contract

      t.timestamps
    end
  end
end
