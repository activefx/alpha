module Extensions
  module Registerable
    extend ActiveSupport::Concern

    included do

      devise :registerable

    end

  end
end 
