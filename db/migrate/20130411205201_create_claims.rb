class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.belongs_to :board, index: true, null: false
      t.string :direction, null: false
      t.integer :tricks, null: false
      t.string :accepted_directions, array: true, default: []
      t.string :rejected_directions, array: true, default: []
      t.string :state

      t.timestamps
    end
  end
end
