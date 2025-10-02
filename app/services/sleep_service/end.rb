module SleepService
  class End < Service::Base
    def initialize(user: , end_time: Time.now)
      @user = user
      @end_time = end_time
    end

    def perform
      s = Sleep.find_by(user_id: @user.id, sleep_end: nil)
      raise SleepService::ActiveSleepNotFoundError unless s

      s.sleep_end = @end_time
      s.save!
    end
  end
end
