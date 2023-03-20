class Message < ApplicationRecord
  validates :user_id, presence: true
  validates :room_id, presence: true
  validates :message, presence: true, length: { maximum: 10000 }
  validate :custom_validation

  belongs_to :user
  belongs_to :room

  def custom_validation
    if Entry.find_by(room: room_id, user_id: user_id).entry_status == false
      errors.add("false")
    end
  end

end
