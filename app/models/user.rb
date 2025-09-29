class User < ApplicationRecord
  validates :name, presence: true

  # Users I am following
  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followee
  
  # Users who are following me
  has_many :passive_follows, class_name: "Follow", foreign_key: "followee_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower
  
  # Add methods for following and unfollowing
  def follow!(other_user)
    following << other_user
  end
  
  def unfollow!(other_user)
    following.delete(other_user)
  end
end
