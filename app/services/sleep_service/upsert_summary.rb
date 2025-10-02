module SleepService
  class UpsertSummary < Service::Base
    def initialize(user: , date: Date.today)
      @user = user
      @date = date
    end

    def perform
      sleeps = Sleep.where(user_id: @user.id).where('? < sleep_start AND sleep_start < ?', @date, @date + 1).where.not(sleep_end: nil)

      summary = Sleep::Summary.find_or_initialize_by(user_id: @user.id, date: @date)
      summary.total_sleep_sessions = sleeps.count
      summary.total_sleep_duration_minutes = sleeps.sum { |s| ((s.sleep_end - s.sleep_start) / 60).to_i }
      summary.save!

      summary
    end
  end
end
