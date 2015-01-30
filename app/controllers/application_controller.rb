class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    helper_method :current_user
  private

  #set and return current user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if @current_user != nil
      if @current_user.admin == true
        session[:admin] = true
      end
    end
    @current_user
  end

  helper_method :admin?
  #redirect to home if user is not an admin
  def admin?
    if session[:admin] == true

    else
      redirect_to root_url
    end
  end

  #if not the current user or admin, deny access and redirect
  def access?(id)
   #binding.pry
    if current_user
      if id == current_user.id || current_user.admin == true
      else
        redirect_to root_url
      end
    else
      redirect_to root_url
    end
  end

  #if user is not logged in, direct them to login
  def authenticate
    if current_user == nil
      redirect_to root_url
    end
  end
  
end
