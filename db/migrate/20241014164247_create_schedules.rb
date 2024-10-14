class CreateSchedules < ActiveRecord::Migration[7.2]
  def change
    create_table :schedules do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
