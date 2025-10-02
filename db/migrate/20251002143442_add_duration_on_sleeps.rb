class AddDurationOnSleeps < ActiveRecord::Migration[8.0]
  def change
    add_column :sleeps, :duration_seconds, :int
  end
end
