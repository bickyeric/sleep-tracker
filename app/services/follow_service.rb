module FollowService
  class SelfFollowError < Service::Error::Base
    def initialize(msg = 'cannot follow yourself'); super; end
  end

  class UserNotFoundError < Service::Error::Base
    def initialize(msg = 'user not found'); super; end
  end

  module_function

  def follow(...); FollowService::Follow.new(...).perform; end
  def unfollow(...); FollowService::Unfollow.new(...).perform; end
end
