class LikesController < ApplicationController
  before_action :require_login
  def create
    @secret=Secret.find(params[:id])
    Like.create(user: current_user, secret: @secret)
    redirect_to "/secrets"
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy if current_user === @like.user
    redirect_to "/secrets"
  end
end
