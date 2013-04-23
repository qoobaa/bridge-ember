class AddAlertToBids < ActiveRecord::Migration
  def change
    add_column :bids, :alert, :text
  end
end
