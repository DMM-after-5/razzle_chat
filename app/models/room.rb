class Room < ApplicationRecord
  validates :owner_id, presence: true
  validates :members_status, presence: true
  validates :name, presence: true, length: { maximum: 80 }
  validates :introduction, length: { maximum: 500 }
  validates :is_deleted, presence: true

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :users, through: :entries
end
