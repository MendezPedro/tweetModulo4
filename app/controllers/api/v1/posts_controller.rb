class Api::V1::PostsController < ApplicationController
  def news
    @posts = Post.limit(50)
    @tweets = []
    @posts.each do |p|
      tweets =  {id: p['id'],content: p['content'],user_id: p['user_id'],like_count: p.likes.count,retweets_count: p.reposts.count,rewtitted_from: p.user.followeds.pluck(:follower_id)[0]}
      @tweets.append(tweets)
    end
    render json: @tweets
  end
  
end
