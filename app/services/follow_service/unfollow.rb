module FollowService
  class Unfollow < Service::Base
    def initialize(user: , followed_user_id:)
      @user = user
      @followed_user_id = followed_user_id
    end

    def perform
      f = ::Follow.find_by(follower_id: @user.id, followee_id: @followed_user_id)
      return unless f

      f.destroy
    end
  end
end
