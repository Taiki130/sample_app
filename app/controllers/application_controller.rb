class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  private

  # ユーザーのログインを確認する
  def logged_in_user
    if not_logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end