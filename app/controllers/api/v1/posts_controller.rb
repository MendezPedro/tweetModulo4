class Api::V1::PostsController < ApplicationController
  def news
    @posts = Post.limit(50)
    render json: @posts
  end
end
