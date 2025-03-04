class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :user_id, uniqueness: { scope: :room_id }

  after_create_commit -> { broadcast_update_to room, target: "participant-count", partial: "rooms/participant_count", locals: { room: room } }
  after_destroy_commit -> { broadcast_update_to room, target: "participant-count", partial: "rooms/participant_count", locals: { room: room } }
end
