class AddLoseToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :lose, :float
  end
end
