class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one_attached :image

  validates :content, presence: true, unless: :image_attached?
  validates :visible, inclusion: { in: [ true, false ] }
  validates :image, content_type: [ "image/png", "image/jpeg", "image/gif" ], size: { less_than: 5.megabytes }

  scope :visible, -> { where(visible: true) }

  after_create_commit -> {
    broadcast_append_to room, target: "messages", partial: "messages/message"
    broadcast_action_to room, action: "scrollToBottom", target: "messages"
  }

  private

  def image_attached?
    image.attached?
  end
end
