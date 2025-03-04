class Room < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :messages, -> { order(created_at: :asc) }, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
end
