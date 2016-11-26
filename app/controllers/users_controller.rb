class UsersController < ApplicationController
  
  def new
  end

  def create
    if user_params[:password] == user_params[:password_confirmation]
      user = User.new(user_params)
      user.role = Role.find_by(name: "user")
      if user.save
        session[:user_id] = user.id
        redirect_to '/'
      else
        redirect_to '/signup'
      end
    else
      raise "Passwords did not match!"
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
