class CreateRequests < ActiveRecord::Migration[7.2]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.timestamp :date_of_request
      t.text :comment
      t.string :request_type
      t.string :request_status

      t.timestamps
    end
  end
end
