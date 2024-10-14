class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :date_availability, :date
    add_column :users, :hours, :integer
    add_column :users, :manager, :boolean
  end
end
