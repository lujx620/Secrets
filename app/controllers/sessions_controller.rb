class SessionsController < ApplicationController
  def new
    render 'users/new'
  end
  def create
    @user= User.find_by_email(params[:email])
    print @user
    if @user.authenticate(params[:password])
      session[:user_id]= @user.id
      redirect_to "/users/show/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages unless @user==nil
      flash[:errors] = ["email/password does not match"]
      flash[:errors] = ["user not found"] if @user==nil
      redirect_to :back
    end
  end
  def logout
    session[:user_id]=nil
    redirect_to '/'
  end
end
