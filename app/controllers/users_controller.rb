class UsersController < ApplicationController
  def index
    
    if params[:q].present?
      #@posts = Post.where(content: params[:q])
      @posts = Post.where('content LIKE ?', "%#{params[:q]}%")
      @user_likes = Like.where(user: current_user).pluck(:post_id)
    else
      @post = Post.find(current_user.id)
      @posts = Post.all
      @user_likes = Like.where(user: current_user).pluck(:post_id)
    end
  end
end
