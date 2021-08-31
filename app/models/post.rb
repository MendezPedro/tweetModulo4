class Post < ApplicationRecord
    validates :content, presence: :true
    belongs_to :user
    has_many :likes
    has_many :reposts, class_name: "Post", foreign_key: "post_id", dependent: :destroy
    belongs_to :original_post, class_name: "Post", foreign_key: "post_id", optional: true

    paginates_per 9
    def photo_retweet
        Post.find(self.post_id).user.photo
    end
    def user_retweet
        Post.find(self.post_id).user.name
    end
    def comment_retweet
        Post.find(self.post_id).content
    end

    #scope :tweets_for_me, -> (user) { where('posts.user_id == ? OR (SELECT follower_id FROM follows WHERE follows.followed_id != ?)',user.id,user.id)}
    #scope :posts_for_me, -> (user) { where(:user_id => user.id)}

    scope :tweets_for_me, -> (user) { where('posts.user_id == ?',user.id)}

    #scope :tweets_for_me, -> (user) { where(:user_id => user.followeds.ids)}
    validates :content, presence: true
end
