class AddUserIdAndSleepStartIndexOnSleeps < ActiveRecord::Migration[8.0]
  def change
    add_index :sleeps, [:user_id, :sleep_start]
  end
end
