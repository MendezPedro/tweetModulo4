class Api::V1::PostsController < ApplicationController
  def news
    #get #http://localhost:3000/api/v1/news
    @posts = Post.limit(50)
    @tweets = []
    @posts.each do |p|
      tweets =  {id: p['id'],content: p['content'],user_id: p['user_id'],like_count: p.likes.count,retweets_count: p.reposts.count,rewtitted_from: p.user.followeds.pluck(:follower_id)[0]}
      @tweets.append(tweets)
    end
    render json: @tweets
  end

  def fecha_a_fecha
    #get #http://localhost:3000/api/v1/2021-08-31/2022-09-05
    @posts = Post.limit(50)
    @tweets = @posts.where(:created_at => params[:fecha1]..params[:fecha2])
    render json: @tweets
  end
  before_action :authenticate_user!
  def create
    @new_post = Post.create(content: params[:post][:content])
    #@post = Post.new(content: params[:post][:content])
    # @post.user = current_user
    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to root_path, notice: 'Nuevo tweet creado'}
    #   else
    #     @user_likes = Like.where(user: current_user).pluck(:post_id)
    #     @posts = Post.all
    #     format.html { redirect_to root_path, notice: 'debe escribir para publicar' }
    #   end
    # end
  end
end
