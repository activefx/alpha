module Extensions
  module Validatable
    extend ActiveSupport::Concern

    included do

      devise :validatable

    end

  end
end 
