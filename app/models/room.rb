class Room < ApplicationRecord
  validates :owner_id, presence: true
  validates :name, presence: true, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries

  # roomにuserが参加済みか判断するメソッド
  def entried?(user)
    entry = entries.find_by(user_id: user.id)
    return false if entry.nil?
    entry.entry_status
  end
end
