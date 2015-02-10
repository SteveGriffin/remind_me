class AdminController < ApplicationController

  def index
  	admin?
  	render 'panel'
  end

  #authentication for admin user
  def authenticate
    if session[:admin] == true
      render 'panel'
    end
    #binding.pry
    user = User.find_by(email: params[:email])
    if user && user.admin == true && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin] = user.admin
      redirect_to admin_panel_path
    else
      flash.now.alert = "Email or password is invalid"
      render plain: "Login failed"
    end
  end

end
