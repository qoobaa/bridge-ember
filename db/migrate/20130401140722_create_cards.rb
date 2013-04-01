class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :board, index: true, null: false
      t.string :content

      t.timestamps
    end

    add_index :cards, [:board_id, :content], unique: true
  end
end
