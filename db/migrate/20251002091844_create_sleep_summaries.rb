class CreateSleepSummaries < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_summaries do |t|
      t.bigint :user_id, null: false
      t.date :date
      t.integer :total_sleep_duration_minutes
      t.integer :total_sleep_sessions

      t.timestamps
    end

    add_index :sleep_summaries, [:user_id, :date], unique: true
  end
end
