class Entry < ApplicationRecord
  validates :entry_status, presence: true

  belongs_to :user
  belongs_to :room
end
