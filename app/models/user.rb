class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy


  def can_follow?(user)
    #se extra a todos los seguidos
    should_follow = self.followers.pluck(:follower_id)
    # con :followed puedo solo ver a los que aun no sigo
    !should_follow.include?(user.id)
    
  end
  
end
