class AddDefaultToUsersManager < ActiveRecord::Migration[7.2]
  def change
    change_column_default :users, :manager, from: nil, to: false
  end
end
