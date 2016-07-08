class AddWinToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :win, :double
  end
end
