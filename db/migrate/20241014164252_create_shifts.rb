class CreateShifts < ActiveRecord::Migration[7.2]
  def change
    create_table :shifts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.date :shift_date
      t.time :shift_time
      t.boolean :clocked_in

      t.timestamps
    end
  end
end
