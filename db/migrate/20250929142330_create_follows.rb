class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.integer :follower_id
      t.integer :followee_id

      t.timestamps
    end

    # Add unique indexes for efficient lookups and to prevent duplicate follows
    add_index :follows, :follower_id
    add_index :follows, :followee_id
    add_index :follows, [:follower_id, :followee_id], unique: true
  end
end
