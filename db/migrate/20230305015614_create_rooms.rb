class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :owner_id, null: false
      t.integer :members_status, null: false, default: 1
      t.string :name, null: false
      t.text :introduction
      t.boolean :is_deleted, null: false, default: false
      t.timestamps
    end
  end
end
