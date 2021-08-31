class PostsController < ApplicationController
  def index
    if params[:q].present?
      @posts = Post.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page(params[:page])
    #elsif user_signed_in?
      #@posts = Post.tweets_for_me(current_user).order(created_at: :desc).page(params[:page])
      #@posts = Post.where(user_id: current_user).page(params[:page])
    else
      @posts = Post.order(created_at: :desc).page(params[:page])
    end
    
    @post = Post.new
    @user_likes = Like.where(user: current_user).pluck(:post_id)
    #@users = User.where('id IS NOT ?', current_user.id).last(6) if user_signed_in?
  end

  def create
    @posts = Post.order(created_at: :desc).limit(50) 
    @post = Post.new(content: params[:post][:content])
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Nuevo tweet creado'}
      else
        @user_likes = Like.where(user: current_user).pluck(:post_id)
        @posts = Post.all
        format.html { redirect_to root_path, notice: 'debe escribir para publicar' }
      end
    end
  end

  def repost
    @post = Post.find(params[:id])
    new_post = Post.create(content: @post.content, user: current_user)
    @post.reposts << new_post
    redirect_to root_path, notice: 'Retweeteado'
  end
  # para mostrar el perfil del usuario
  def show
    @post = Post.find(params[:id])
    @post_likes = @post.likes
    #@user_likes = Like.where(user: current_user)
  end
  

end
