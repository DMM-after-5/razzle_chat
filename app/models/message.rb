class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :message, presence: true, length: { maximum: 10000 }

  belongs_to :user
  belongs_to :room
end
