module SleepService
  class ActiveSleepExistError < Service::Error::Base
    def initialize(msg = 'active sleep is exist'); super; end
  end

  class SleepNotFoundError < Service::Error::Base
    def initialize(msg = 'sleep is not found'); super; end
  end

  class SleepEndedError < Service::Error::Base
    def initialize(msg = 'sleep is already ended'); super; end
  end

  module_function

  def start(...); Start.new(...).perform; end
  def end(...); End.new(...).perform; end
  def upsert_summary(...); UpsertSummary.new(...).perform; end
  def friend_feed(...); FriendFeed.new(...).perform; end
  def stats(...); Stats.new(...).perform; end
end
