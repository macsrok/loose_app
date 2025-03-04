class MessagesController < ApplicationController
  def create
    @room = Current.user.rooms.find(params[:room_id])
    @message = @room.messages.build(message_params)
    @message.user = Current.user
    @message.save

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @room }
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
