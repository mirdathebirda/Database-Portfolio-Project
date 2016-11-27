class UsersController < ApplicationController
  
  def new
  end

  def create
    if user_params[:password] == user_params[:password_confirmation]
      user = User.new(user_params)
      if user.save
        session[:user_id] = user.id
        User.connection.execute "INSERT INTO user_role (user, role) VALUES (#{user.id}, #{Role.find_by(name: "user").id});"
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
