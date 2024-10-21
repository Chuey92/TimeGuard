class AddSwapScheduleIdToRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :requests, :swap_schedule_id, :integer
  end
end
