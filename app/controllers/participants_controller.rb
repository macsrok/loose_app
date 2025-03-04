class ParticipantsController < ApplicationController
  include ActionView::RecordIdentifier
  before_action :set_room, only: [ :create ]

  def create
    user_ids = Array(participant_params[:user_id])
    @participants = user_ids.map { |user_id| @room.participants.build(user_id: user_id) }

    if @participants.all?(&:save)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("participants", partial: "participants/participant", collection: @room.participants),
            turbo_stream.update("participant-count", partial: "rooms/participant_count", locals: { room: @room }),
            turbo_stream.remove("add-participant-modal")
          ]
        end
        format.html { redirect_to @room }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("add-participant-error",
            partial: "shared/error_messages",
            locals: { errors: @participants.map(&:errors).flatten }
          )
        end
        format.html { redirect_to @room, alert: "Failed to add participants" }
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @room = @participant.room
    is_self_removal = @participant.user == Current.user

    if @participant.destroy
      respond_to do |format|
        format.turbo_stream do
          if is_self_removal
            render turbo_stream: turbo_stream.action(:visit, rooms_path)
          else
            render turbo_stream: [
              turbo_stream.remove(dom_id(@participant)),
              turbo_stream.update("participant-count", partial: "rooms/participant_count", locals: { room: @room })
            ]
          end
        end
        format.html do
          if is_self_removal
            redirect_to rooms_path, notice: "You have left the room."
          else
            redirect_to @room
          end
        end
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("participant-#{@participant.id}-error",
            partial: "shared/error_messages",
            locals: { errors: @participant.errors }
          )
        end
        format.html { redirect_to @room, alert: "Failed to remove participant" }
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def participant_params
    params.require(:participant).permit(user_id: [])
  end
end
