class AdminController < ApplicationController

  def index
  end

  #authentication for admin user
  def authenticate
    if session[:admin] == true
      render 'dashboard'
    end

    user = User.find_by(email: params[:email])
    if user && user.admin == true && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin] = user.admin
      redirect_to admin_dashboard_path
    else
      flash.now.alert = "Email or password is invalid"
      render plain: "Login failed"
    end
  end

end
