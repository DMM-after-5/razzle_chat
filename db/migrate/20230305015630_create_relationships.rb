class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :follower, null: false, type: :integer, foreign_key: { to_table: :users }
      t.references :followed, null: false, type: :integer, foreign_key: { to_table: :users }
      t.timestamps
      t.index [:follower_id, :followed_id], unique: true, name: 'follow_unique_index'
    end
  end
end
