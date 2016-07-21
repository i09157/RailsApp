class AddWinToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :win, :float
  end
end
