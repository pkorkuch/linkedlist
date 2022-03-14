class StaticPagesController < ApplicationController
  def home
    return redirect_to login_url unless logged_in?

    redirect_to user_url(current_user)
  end

  def about; end

  def contact; end

  def help; end
end
