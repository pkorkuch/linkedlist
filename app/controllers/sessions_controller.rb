class SessionsController < ApplicationController
  before_action :check_recaptcha, only: :create

  def new
    @turbo_reload = true
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user&.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        flash.now[:error] = 'User is not activated.'
        render 'new', status: :unprocessable_entity
      end
    else
      flash.now[:error] = 'Invalid email or password'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url, status: :see_other
  end

  private

  def check_recaptcha
    GRecaptcha::ApiClient.verify_response(params['g-recaptcha-response'])
  end
end
