class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callback]

  def new
  end

  def create
    user = User.find_by username: params[:username]
    if user.nil? or not user.authenticate params[:password]
      redirect_to :back, notice: 'Username and password do not match!'
    else
      session[:user_id] = user.id unless user.nil?
      redirect_to user, notice: 'Welcome back!'
    end
  end

  def callback
    user = User.from_omniauth(env["omniauth.auth"])
    unless user.nil?
      session[:user_id] = user.id unless user.nil?
      redirect_to user, notice: 'Welcome back!'
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to :root
  end
end
