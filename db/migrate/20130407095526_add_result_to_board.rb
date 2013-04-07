class AddResultToBoard < ActiveRecord::Migration
  def change
    add_column :boards, :result, :integer
  end
end
