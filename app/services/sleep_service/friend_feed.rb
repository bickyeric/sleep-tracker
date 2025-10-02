module SleepService
  class FriendFeed < Service::Base
    DURATION = 1.week.ago
    def initialize(user:)
      @user = user
    end

    def perform
      Rails.cache.fetch("user#{@user.id}_friend_feeds_v1", expires_in: 1.hour, race_condition_ttl: 5.minutes) do
        # todo: not optimized yet
        Sleep.includes(:user).where(user: @user.following)
              .where(created_at: 1.week.ago..Time.current)
              .where.not(sleep_end: nil)
              .order(:duration_seconds)
              .to_a
      end
    end
  end
end
