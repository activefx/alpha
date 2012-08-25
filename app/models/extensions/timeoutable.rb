module Extensions
  module Timeoutable
    extend ActiveSupport::Concern

    included do

      devise :timeoutable

    end

  end
end 
