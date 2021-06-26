class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if authenticatable?(user)
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def authenticatable?(user)
    user.present? && user.not_activated? && user.authenticated?(:activation, params[:id])
  end

end