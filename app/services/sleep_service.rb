module SleepService
  class ActiveSleepExistError < Service::Error::Base
    def initialize(msg = 'active sleep is exist'); super; end
  end

  class ActiveSleepNotFoundError < Service::Error::Base
    def initialize(msg = 'active sleep is not found'); super; end
  end

  module_function

  def start(...); Start.new(...).perform; end
  def end(...); End.new(...).perform; end
end
