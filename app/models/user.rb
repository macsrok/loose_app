class User < ApplicationRecord
  has_secure_password

  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants
  has_many :sessions, dependent: :destroy
  has_many :messages

  has_one_attached :avatar

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :display_name, with: ->(name) { name.strip }

  validates :email_address, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validates :display_name, presence: true
  validates :avatar, content_type: [ "image/png", "image/jpeg", "image/gif" ], size: { less_than: 15.megabytes }

  before_validation :set_default_display_name

  def avatar_variant(size)
    return nil unless avatar.attached?
    avatar.variant(resize_to_limit: [ size, size ]).processed
  end

  private

  def set_default_display_name
    self.display_name = email_address if display_name.blank?
  end
end
