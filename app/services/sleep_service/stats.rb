module SleepService
  class Stats < Service::Base
    def initialize(user: , period: 1.month)
      @user = user
      @period = period
    end

    def perform
      Rails.cache.fetch("user#{@user.id}_sleep_stats_#{@period.inspect}", expires_in: 1.hour) do
        # todo: check if this is optimized
        summaries = Sleep::Summary.where(user_id: @user.id).where('date > ?', @period.ago)

        total_minutes = summaries.sum(&:total_sleep_duration_minutes)
        total_sessions = summaries.sum(&:total_sleep_sessions)

        {
          total_sleep_duration_minutes: total_minutes.to_i,
          total_sleep_duration_hours: (total_minutes / 60),
          total_number_of_sleep_sessions: total_sessions,
          total_days: summaries.size,
        }
      end
    end
  end
end
