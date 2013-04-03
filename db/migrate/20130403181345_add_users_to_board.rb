class AddUsersToBoard < ActiveRecord::Migration
  def change
    change_table(:boards) do |t|
      t.belongs_to :user_n, index: true, null: false
      t.belongs_to :user_e, index: true, null: false
      t.belongs_to :user_s, index: true, null: false
      t.belongs_to :user_w, index: true, null: false
    end
  end
end
