class HomeController < ApplicationController
  skip_before_action :require_authentication

  def index
    if authenticated?
      redirect_to rooms_path
    end
  end
end
