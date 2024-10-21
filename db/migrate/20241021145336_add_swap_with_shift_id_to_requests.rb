class AddSwapWithShiftIdToRequests < ActiveRecord::Migration[7.2]
  def change
    add_column :requests, :swap_with_shift_id, :integer
  end
end
