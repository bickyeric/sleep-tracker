module FollowService
  class Follow < Service::Base
    def initialize(user: , followed_user_id:)
      @user = user
      @followed_user_id = followed_user_id
    end

    def perform
      raise SelfFollowError if @user.id == @followed_user_id.to_i

      raise UserNotFoundError unless followed_user

      ::Follow.new(follower_id: @user.id, followee_id: followed_user.id).save!
    rescue ActiveRecord::RecordInvalid
      # do nothing since follower already follow the user
      nil
    end

    private

    def followed_user
      @followed_user ||= User.find_by id: @followed_user_id
    end
  end
end
