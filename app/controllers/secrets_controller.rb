class SecretsController < ApplicationController
  before_action :require_login
  def index
    @user= User.all
    @secrets=Secret.all
  end

  def create
    # secret= Secret.new secret_params
    user= User.find(session[:user_id])
    Secret.create(content: params[:content], user: current_user)
    # if secret.save
    redirect_to :back
    end

  def delete
    Secret.find(params[:id]).destroy
    redirect_to :back
  end
#
# private
#   def secret_params
#     params.require(:secret).permit(:content).merge(user: current_user)
#   end
end
