class UpsertSleepSummaryJob < ApplicationJob
  queue_as :default

  def perform(user_id, date)
    user = User.find user_id

    SleepService.upsert_summary(user: user, date: date)
  end
end
