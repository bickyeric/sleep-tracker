module SleepService
  class ActiveSleepExistError < Service::Error::Base
    def initialize(msg = 'active sleep is exist'); super; end
  end

  module_function

  def start(...); Start.new(...).perform; end
end
