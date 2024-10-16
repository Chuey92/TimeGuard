class AddDefaultsToUsers < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :hours, from: nil, to: 0
  end
end
