class BookmarksController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find(params[:user_id])
  end

  def create
    link_post = LinkPost.find_by(id: params[:post_id])
    return head :bad_request if link_post.nil?

    current_user.bookmarks.find_or_create_by(link_post_id: params[:post_id])
    respond_to do |format|
      format.html do
        flash[:success] = 'Successfully created bookmark.'
        redirect_back_or_to root_url
      end
    end
  end

  def destroy
    bookmark = Bookmark.find_by(id: params[:id])
    return head :not_found if bookmark.nil?
    return head :forbidden unless bookmark.user == current_user

    bookmark.destroy
    respond_to do |format|
      format.html do
        flash[:success] = 'Successfully removed bookmark.'
        redirect_back_or_to root_url
      end
    end
  end
end
