class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :board, index: true, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
