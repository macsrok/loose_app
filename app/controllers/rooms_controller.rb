class RoomsController < ApplicationController
  def index
    @rooms = Current.user.rooms
  end

  def new
    @room = Room.new
    @users = User.where.not(id: Current.user.id)
  end

  def create
    @room = Room.new(room_params)
    @room.participants.build(user: Current.user)

    if @room.save
      redirect_to @room, notice: "Room was successfully created."
    else
      @users = User.where.not(id: Current.user.id)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @room = Current.user.rooms.find(params[:id])
  end

  private

  def room_params
    params.require(:room).permit(:name, participant_ids: [])
  end
end
