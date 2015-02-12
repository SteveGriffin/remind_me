class AuthenticationController < ApplicationController

  def create

    auth = request.env["omniauth.auth"]
    #binding.pry
    begin
      user = User.find_by_provider_and_email(auth["provider"], auth["info"]["email"]) || User.create_with_omniauth(auth)
      session[:user_id] = user.id
      #check if user is admin
      if user.admin == true
      	session[:admin] = true
      else
      	session[:admin] = false
      end
      redirect_to dashboard_path(user.id), :notice => "Signed in!"
      #binding.pry
    rescue Exception => e
      redirect_to root_url, :notice => e.to_s
    end

  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    session[:admin] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
