class AddCoordinatesToSites < ActiveRecord::Migration[7.2]
  def change
    add_column :sites, :latitude, :float
    add_column :sites, :longitude, :float
  end
end
