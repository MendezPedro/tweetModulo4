class LikesController < ApplicationController
  before_action :authenticate_user!
  def to_like
    post = Post.find(params[:id])
    new_like = Like.create!(post: post, user: current_user)
    redirect_to root_path
  end

  def to_dislike
    post = Post.find(params[:id])
    like = post.likes.find_by(user: current_user)
    like.destroy
    redirect_to root_path
  end
end
