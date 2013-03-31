class AddUniqueIndexOnNameToChannels < ActiveRecord::Migration
  def change
    add_index :channels, :name, unique: true
  end
end
