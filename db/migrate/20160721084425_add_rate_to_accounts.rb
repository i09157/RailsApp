class AddRateToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :rate, :float
  end
end
