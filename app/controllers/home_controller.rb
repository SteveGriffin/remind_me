class HomeController < ApplicationController

  def index
    if current_user.nil?
      render 'index'
    else
      redirect_to dashboard_path(current_user.id)
    end
  end
end
