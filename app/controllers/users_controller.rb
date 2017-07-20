class UsersController < ApplicationController
  before_action :require_login, only:[:show, :edit, :delete, :update]

  def new
    render 'users/new_users'
  end
  def create
    @user= User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.valid?
      session[:user_id]= @user.id
      redirect_to "/users/show/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @user= User.find(params[:id])
    render 'users/dashboard'
  end
  def edit
    @user= User.find(params[:id])
    render 'users/edit'
  end

  def delete
    User.find(params[:id]).destroy
    reset_session
    redirect_to '/users/new'
  end

  def update
    @user= User.find(params[:id])
    if @user.update(user_params)
      redirect_to "/users/show/#{@user.id}"
    else
      flash[:errors]=@user.errors.full_messages
      redirect_to :back
    end
  end
private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
