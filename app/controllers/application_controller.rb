class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    return if logged_in?

    store_location
    flash[:warning] = 'Please log in'
    redirect_to login_url
  end

  def correct_user
    @user = User.find(params[:user_id] || params[:id])
    return if current_user?(@user)

    flash[:error] = 'Access forbidden'
    redirect_to root_url
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
