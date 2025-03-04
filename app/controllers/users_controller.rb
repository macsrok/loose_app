class UsersController < ApplicationController
  allow_unauthenticated_access only: [ :new, :create ]
  before_action :set_user, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for(@user)
      redirect_to after_authentication_url, notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if user_params[:avatar].present?
      if @user.update(avatar_params)
        redirect_to edit_user_path(@user), notice: "Profile picture was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    elsif user_params[:password].present?
      # Verify current password
      if !@user.authenticate(user_params[:current_password])
        @user.errors.add(:current_password, "is incorrect")
        return render :edit, status: :unprocessable_entity
      end

      if @user.update(password_params)
        redirect_to edit_user_path(@user), notice: "Password was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    elsif user_params[:display_name].present?
      if @user.update(display_name_params)
        redirect_to edit_user_path(@user), notice: "Name was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to edit_user_path(@user), alert: "No changes were made."
    end
  end

  private

  def set_user
    @user = Current.user
  end

  def user_params
    params.require(:user).permit(:email_address, :password, :password_confirmation, :current_password, :display_name, :avatar)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def display_name_params
    params.require(:user).permit(:display_name)
  end

  def avatar_params
    params.require(:user).permit(:avatar)
  end
end
