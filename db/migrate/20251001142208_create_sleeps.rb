class CreateSleeps < ActiveRecord::Migration[8.0]
  def change
    create_table :sleeps do |t|
      t.bigint :user_id, null: false
      t.datetime :sleep_start, null: false
      t.datetime :sleep_end

      t.timestamps
    end

    add_index :sleeps, :user_id,
              name: "index_sleeps_on_user_id_where_sleep_end_null",
              where: "sleep_end IS NULL"
  end
end
