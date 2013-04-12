class CreateClaims < ActiveRecord::Migration
  def change
    create_table :claims do |t|
      t.belongs_to :board, index: true, null: false
      t.string :direction, null: false
      t.integer :tricks, null: false
      t.string :accepted, array: true, default: []
      t.string :rejected, array: true, default: []

      t.timestamps
    end
  end
end
