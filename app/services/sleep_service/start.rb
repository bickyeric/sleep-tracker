module SleepService
  class Start < Service::Base
    def initialize(user: , start_time: Time.now)
      @user = user
      @start_time = start_time
    end

    def perform
      raise SleepService::ActiveSleepExistError if Sleep.exists?(user_id: @user.id, sleep_end: nil)

      s = Sleep.new(user_id: @user.id, sleep_start: @start_time)
      s.save!
    end
  end
end
