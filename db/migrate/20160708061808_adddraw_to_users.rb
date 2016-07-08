class AdddrawToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :draw, :double
  end
end
