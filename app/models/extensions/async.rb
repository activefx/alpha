module Extensions
  module Async
    extend ActiveSupport::Concern

    included do

      devise :async

    end

  end
end
