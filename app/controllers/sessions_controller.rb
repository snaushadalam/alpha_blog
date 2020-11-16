class SessionsController < ApplicationController
  def new

  end
  def create
    user= User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id]=user.id
      flash[:notice]="Successfully Logged In "
      redirect_to user_path(user)
    else
      flash.now[:alert]="There was something Wrong in given details"
      render 'new'
    end
  end
  def destroy
    session[:user_id]=nil
    flash[:notice]="Successfully Logged Out "
    redirect_to root_path
  end
end