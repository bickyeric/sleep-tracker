module Service
  class Base
    def perform
      raise NotImplementedError, 'You must implement this method'
    end
  end

  module Error
    class Base < StandardError; end
  end
end
