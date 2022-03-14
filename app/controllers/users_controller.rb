class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy

  def index
    limit = 30 # Max number of records per page
    @current_page = params[:page]&.to_i || 1 # Pages are 1-indexed
    @total_pages = (User.count / limit.to_f).ceil

    # Offset is 0-indexed, and we need to subtract 1 from page since page is 1-indexed
    @users = User.order(:created_at).limit(limit).offset((@current_page - 1) * limit)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = 'Successfully signed up'
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Successfully updated profile'
      redirect_to @user
    else
      flash.now[:error] = @user.errors.full_messages
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
