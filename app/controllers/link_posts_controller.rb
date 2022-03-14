class LinkPostsController < ApplicationController
  before_action :logged_in_user, only: %i[new create edit update destroy]
  before_action :correct_user, only: %i[new create]

  def show
    @link_post = LinkPost.find(params[:id])
    render 'show', layout: 'application_minimal'
  end

  def new
    @link_post = LinkPost.new
  end

  def create
    @link_post = current_user.link_posts.build(link_post_params)
    if @link_post.save
      flash[:success] = 'Created post'
      redirect_to @link_post
    else
      flash.now[:error] = @link_post.errors.full_messages
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def link_post_params
    params.require(:link_post).permit(:link_text, :link, :content)
  end
end
