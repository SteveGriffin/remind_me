class DashboardController < ApplicationController
  before_action :authenticate

  def show
  end

  helper_method :user_has_phone?
  #check if user has a phone number
  def user_has_phone?
    if current_user.phone == nil
      false
    else
      true
    end
  end

  def update_user_phone
    user = User.find(params[:id])
    user.update(phone: User.sanitize_phone(params[:user][:phone]))
    redirect_to dashboard_path(user.id)
  end




end
