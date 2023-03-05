class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :user, null: false, type: :integer, foreign_key: true
      t.references :room, null: false, type: :integer, foreign_key: true
      t.boolean :entry_status, null: false, default: false
      t.timestamps
      t.index [:user_id, :room_id], unique: true
    end
  end
end
