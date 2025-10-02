module SleepService
  class End < Service::Base
    def initialize(user: ,sleep_id: , end_time: Time.now)
      @user = user
      @sleep_id = sleep_id
      @end_time = end_time
    end

    def perform
      s = Sleep.find_by(id: @sleep_id, user_id: @user.id)
      raise SleepService::SleepNotFoundError unless s
      raise SleepService::SleepEndedError unless s.sleep_end.nil?

      s.sleep_end = @end_time
      s.save!

      UpsertSleepSummaryJob.perform_later(@user.id, Date.current)

      s
    end
  end
end
