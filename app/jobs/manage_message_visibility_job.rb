class ManageMessageVisibilityJob < ApplicationJob
  queue_as :default

  def perform
    Room.find_each do |room|
      # Get IDs of the 10 most recent visible messages
      recent_message_ids = room.messages.visible.order(created_at: :desc).limit(10).select(:id)

      # Find all visible messages that aren't in the recent list and hide them
      room.messages.visible.where.not(id: recent_message_ids).update_all(visible: false)
    end
  end
end
