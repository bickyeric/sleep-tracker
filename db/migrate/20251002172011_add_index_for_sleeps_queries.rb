class AddIndexForSleepsQueries < ActiveRecord::Migration[8.0]
  def change
    # For friend feed
    add_index :sleeps, [:user_id, :created_at, :duration_seconds]

    # For user timeline pagination
    add_index :sleeps, [:user_id, :created_at, :id]
  end
end
